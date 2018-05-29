
default:
	cp myservicechecker /bin/myservicechecker
	crontab -l >> tmpcrontab
	chmod u+wx tmpcrontab
	@echo '* * * * *       myservicechecker >> /var/log/myservicechecker.log 2>>/var/log/myservicechecker.log' >> tmpcrontab
	cat tmpcrontab | crontab -

	cp chatworker /etc/init.d/myservice
	chmod u+x /etc/init.d/myservice
	-systemctl enable myservice > /dev/null 2>/dev/null
	systemctl daemon-reload
	systemctl reset-failed
	service myservice start
	make clean
	service myservice status
clean:
	@echo "clean all"
	rm tmpcrontab
