from pyHS100 import Discover
import json
import datetime

now = datetime.datetime.now()

rows = {}
row = { }
row['systemtime'] = now.strftime('%m/%d/%Y %H:%M:%S')
year = now.year
month = now.month

for dev in Discover.discover().values():
    row['host'] = dev.host
    sysinfo = dev.get_sysinfo()
    for k, v in dev.get_emeter_realtime().items():
        row["%s" % k] = v
    for k, v in sysinfo.items():
        row["%s" % k] = v
    emeterdaily = dev.get_emeter_daily(year=year, month=month)
    for k, v in emeterdaily.items():
        row["day%s" % k] = v
    hwinfo = dev.hw_info
    for k, v in hwinfo.items():
        row["%s" % k] = v
    timezone = dev.timezone
    for k, v in timezone.items():
        row["%s" % k] = v
    emetermonthly =  dev.get_emeter_monthly(year=year)
    for k, v in emetermonthly.items():
        row["month%s" % k] = v
    row['current_consumption'] = dev.current_consumption()
    row['alias'] = dev.alias
    row['time'] =  dev.time.strftime('%m/%d/%Y %H:%M:%S')
    row['ledon'] = dev.led
    rows["host%s" % dev.host] = row

json_string = json.dumps(rows)
print (json_string)
