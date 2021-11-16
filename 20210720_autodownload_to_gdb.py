from time import strftime
print(strftime('%c'))

from arcgis.gis import GIS

### Input Variables 
itemid = '912bd750296e4d96895bc4ceaabf682e'
output = r'C:\CoastSnap\CoastSnap_backup_test'
tempfile = strftime('%Y_%m_%d_CoastSnap_backup')

# Create Backup
gis = GIS('https://erdcchl.maps.arcgis.com/', 'Jessie.Straub', '1LoveCali!1593')
dataitem = gis.content.get(itemid)
dataitem.export(tempfile, 'File Geodatabase', parameters=None, wait=True)
myexport = gis.content.search(tempfile, item_type='File Geodatabase')
fgdb = gis.content.get(myexport[0].itemid)
fgdb.download(save_path=output)
fgdb.delete()

print('Script Complete at {}'.format(strftime('%c')))
