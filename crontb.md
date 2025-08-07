# Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command

15 23 * * * /home/anon/.bin/bedtime.sh && /home/anon/.bin/set_wp.sh

@reboot xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s /home/anon/media/wp/mint.jpg

00 08 * jan * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
15 07 * feb * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
10 06 * mar * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
45 05 * apr * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
10 05 * may * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
45 04 * jun * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
00 05 * jul * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
45 05 * aug * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
40 06 * sep * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
30 07 * oct * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
55 07 * nov * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png
10 08 * dec * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.day.png

00 16 * jan * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
00 17 * feb * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
00 18 * mar * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
45 19 * apr * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
30 20 * may * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
15 21 * jun * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
10 21 * jul * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
15 20 * aug * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
00 19 * sep * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
45 17 * oct * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
30 16 * nov * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png
00 16 * dec * DISPLAY=:0 /home/anon/.bin/apply_wp.sh /home/anon/.night.png


@reboot /usr/bin/unclutter-xfixes -idle 3 &


