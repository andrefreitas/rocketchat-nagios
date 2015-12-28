# Rocketchat Nagios Plugin
Creates Rocketchat notifications from Nagios.

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
Launch a development instance of Rocket with Docker:

    docker-compose up
