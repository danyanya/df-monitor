# df-monitor
Disk usage monitoring script with alert to mail

# Usage
Put df-monitor.sh somewhere on local machine and add check to cron:

```bash

echo $(crontab -l ; echo '*/20 1 * * * df-monitor.sh -t <threshold> -e <your_email> -c <path_to_sendmail>') | crontab -

```