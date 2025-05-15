from typesense.api_call import ObjectNotFound
from acdh_cfts_pyutils import TYPESENSE_CLIENT as client
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import (
    extract_fulltext,
    get_xmlid,
    make_entity_label,
    check_for_hash,
)
from acdh_xml_pyutils.xml import NSMAP
from tqdm import tqdm


COLLECTION_NAME = "daacda"

try:
    client.collections[COLLECTION_NAME].delete()
except ObjectNotFound:
    pass

current_schema = {
    "name": COLLECTION_NAME,
    "enable_nested_fields": True,
    "fields": [
        {"name": "id", "type": "string", "sort": True},
        {"name": "surname", "type": "string", "sort": True},
        {"name": "forename", "type": "string", "facet": True, "sort": True},
        {"name": "full_name", "type": "string", "sort": True},
        {"name": "marc", "type": "string", "facet": True, "sort": True},
        {"name": "marc_destiny", "type": "string", "facet": True, "sort": True},
        {"name": "rank", "type": "string", "facet": True, "sort": True},
        {"name": "role", "type": "string", "facet": True, "sort": True},
        {"name": "squadron", "type": "object", "facet": True},
        # {"name": "bomb_group", "type": "string", "facet": True, "sort": True},
        # {"name": "airforce", "type": "string", "facet": True, "sort": True},
        # {"name": "prisons", "type": "object[]", "facet": True, "optional": True},
        # {"name": "place_of_birth", "type": "object", "facet": True, "optional": True},
        # {"name": "place_of_death", "type": "object", "facet": True, "optional": True},
    ],
}

client.collections.create(current_schema)
records = []
doc = TeiReader("./data/indices/listperson.xml")
items = doc.any_xpath(".//tei:person[@xml:id]")
for x in tqdm(items, total=len(items)):
    record = {}
    xml_id = get_xmlid(x)
    record["id"] = xml_id
    record["surname"] = extract_fulltext(x.xpath(".//tei:surname", namespaces=NSMAP)[0])
    record["forename"] = extract_fulltext(x.xpath(".//tei:forename", namespaces=NSMAP)[0])
    try:
        middle_name = x.xpath(".//tei:forename[@type='middle']", namespaces=NSMAP)[0].text
        record["full_name"] = f'{record["surname"]}, {record["forename"]} {middle_name}'
    except IndexError:
        record["full_name"] = f'{record["surname"]}, {record["forename"]}'
    record["marc"] = extract_fulltext(x.xpath("./tei:idno[@type='marc-id']", namespaces=NSMAP)[0])
    record["marc_destiny"] = extract_fulltext(x.xpath("./tei:note[@type='eintrag-macr']", namespaces=NSMAP)[0])
    record["rank"] = x.xpath("./tei:occupation/@role", namespaces=NSMAP)[0]
    record["role"] = extract_fulltext(x.xpath("./tei:occupation", namespaces=NSMAP)[0])
    squad_id = x.xpath("./tei:affiliation[@type='squad']/tei:orgName/@key", namespaces=NSMAP)[0]
    squad_label = extract_fulltext(x.xpath("./tei:affiliation[@type='squad']/tei:orgName", namespaces=NSMAP)[0])
    record["squadron"] = {
        "id": squad_id,
        "label": squad_label
    }
    records.append(record)

make_index = client.collections[COLLECTION_NAME].documents.import_(records)
print(make_index)
print(f"done with indexing {COLLECTION_NAME}")
