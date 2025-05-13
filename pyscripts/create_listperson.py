import glob
from slugify import slugify
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import extract_fulltext
from acdh_xml_pyutils.xml import NSMAP as nsmap
from csae_pyutils import save_json


files = sorted(glob.glob("data/editions/*.xml"))

data = {}
for x in files:
    doc = TeiReader(x)
    labels = doc.any_xpath(".//tei:table[@xml:id='crew_table']/tei:row[@role='label']//tei:cell")
    for crew in doc.any_xpath(".//tei:table[@xml:id='crew_table']/tei:row[@role='data']"):
        item = {}
        for i, y in enumerate(crew.xpath("./tei:cell", namespaces=nsmap)[:9]):
            abbr = slugify(extract_fulltext(labels[i].xpath(".//tei:abbr", namespaces=nsmap)[0]))
            item[abbr] = extract_fulltext(y)
        xmlid = item["interne-id"]
        data[f"person__{xmlid}"] = item

save_json(data, "foo.json")
