import os
import glob


files = sorted(glob.glob("./data/editions/*.xml"))

for x in files:
    path, old_name = os.path.split(x)
    cr_nr = old_name.split("__")[-1].replace(".xml", "")
    new_name = f"a-{cr_nr:0>4}.xml"
    save_path = os.path.join(path, new_name)
    os.rename(x, save_path)
    
