docker exec -it  ubuntu_rq bash

#添加admin用户远程访问
rabbitmqctl add_user 'admin' 'admin'
#授予虚拟机“/”权限
rabbitmqctl set_permissions -p "/" admin ".*" ".*" ".*" 
#授予管理平台登陆权限
rabbitmqctl set_user_tags admin administrator 
或者直接合并为一句话
rabbitmqctl add_user 'admin' 'admin' && rabbitmqctl set_permissions -p "/" admin ".*" ".*" ".*" && rabbitmqctl set_user_tags admin administrator
