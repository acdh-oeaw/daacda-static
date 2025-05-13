import glob
import lxml.etree as ET
from tqdm import tqdm
from slugify import slugify
from acdh_tei_pyutils.tei import TeiReader
from acdh_tei_pyutils.utils import extract_fulltext, get_xmlid
from acdh_xml_pyutils.xml import NSMAP as nsmap
from csae_pyutils import save_json


files = sorted(glob.glob("data/editions/*.xml"))

data = {}
for x in tqdm(files):
    doc = TeiReader(x)
    labels = doc.any_xpath(
        ".//tei:table[@xml:id='crew_table']/tei:row[@role='label']//tei:cell"
    )
    relation_labels = doc.any_xpath(
        ".//tei:cell/tei:table/tei:row[@role='label'][1]//tei:cell"
    )
    for crew in doc.any_xpath(
        ".//tei:table[@xml:id='crew_table']/tei:row[@role='data']"
    ):
        item = {}
        for i, y in enumerate(crew.xpath("./tei:cell", namespaces=nsmap)[:9]):
            abbr = slugify(
                extract_fulltext(labels[i].xpath(".//tei:abbr", namespaces=nsmap)[0])
            )
            item[abbr] = extract_fulltext(y)
        stations = []
        for n, z in enumerate(crew.xpath(".//tei:row[@role='data']", namespaces=nsmap)):
            station_data = {}
            for i, y in enumerate(z.xpath("./tei:cell", namespaces=nsmap)):
                station_abbr = slugify(
                    extract_fulltext(
                        relation_labels[i].xpath(".//tei:abbr", namespaces=nsmap)[0]
                    )
                )
                station_data[station_abbr] = extract_fulltext(y)
            stations.append(station_data)
        item["stations"] = stations
        xmlid = item["interne-id"]
        data[f"person__{xmlid}"] = item
    for x in doc.any_xpath(".//tei:person[@xml:id]"):
        xmlid = get_xmlid(x)
        try:
            data[xmlid]["node"] = ET.tostring(x, encoding="utf-8").decode("utf-8")
        except KeyError:
            print(f"upsi days; {xmlid} is missing")

save_json(data, "foo.json")
