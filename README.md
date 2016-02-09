# Rocketchat Nagios Plugin
Send notifications to a Rocketchat channel from Nagios.

![Screenshot](images/screenshot.png)

# Usage
Assuming you are using Nagios 4, the steps are:

1. Copy _rocketchat.py_ to /usr/local/nagios/libexec.
2. Create the notification command __(replace WEBHOOK_URL)__:

        define command {
              command_name notify-service-by-rocketchat
              command_line /usr/local/nagios/libexec/rocketchat.py --url WEBHOOK_URL --hostalias "$HOSTNAME$" --notificationtype "$NOTIFICATIONTYPE$" --servicedesc "$SERVICEDESC$" --servicestate "$SERVICESTATE$" --serviceoutput "$SERVICEOUTPUT$"
        }

        define command {
              command_name notify-host-by-rocketchat
              command_line /usr/local/nagios/libexec/rocketchat.py --url WEBHOOK_URL --hostalias "$HOSTNAME$" --notificationtype "$NOTIFICATIONTYPE$" --hoststate "$HOSTSTATE$" --hostoutput "$HOSTOUTPUT$"
        }

3. Create the contact:

        define contact {
          contact_name                             rocketchat
          alias                                    Rocketchat
          service_notification_period              24x7
          host_notification_period                 24x7
          service_notification_options             w,u,c,r
          host_notification_options                d,r
          service_notification_commands            notify-service-by-rocketchat
          host_notification_commands               notify-host-by-rocketchat
        }

4. Add the contact to a contact group:


        define contactgroup{
            contactgroup_name   network-admins
            alias               Network Administrators
            members             email, rocketchat
        }

# Contributing
1. Launch a development instance of Rocket with Docker:

        docker-compose up


2. Create a new user and channel by accessing Rocket Chat in your browser.

3. Create a new channel called _nagios_.

4. Create a new incoming webhook integration for that channel.

5. Create a file url.txt with the complete url of the webhook:

        http://192.168.99.100:32769/hooks/jyfgPbsat6cKYxXWS/rocket.cat/O1%2B5u6L2OzvJJYyH6wcfEYifcbbUvoOVsP37Zd%2Fc3b0%3D

6. Test a notification:

        make test-ok test-critical test-unknown test-warning
