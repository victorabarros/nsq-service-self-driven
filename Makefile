YELLOW=\033[0;33m
NOCOLOR=\033[0m

welcome:
	@clear
	@echo "${YELLOW}                   _ __   ___   __ _                   ${NOCOLOR}" && sleep .03
	@echo "${YELLOW}                  | '_ \ / __| / _' |                  ${NOCOLOR}" && sleep .03
	@echo "${YELLOW}                  | | | |\__ \| (_| |                  ${NOCOLOR}" && sleep .03
	@echo "${YELLOW}                  |_| |_||___/ \__, |                  ${NOCOLOR}" && sleep .03
	@echo "${YELLOW}                                  | |                  ${NOCOLOR}" && sleep .03
	@echo "${YELLOW}                                  |_|                  ${NOCOLOR}" && sleep .03
	@echo "${YELLOW}            _   __  ______        _                    ${NOCOLOR}" && sleep .03
	@echo "${YELLOW}           | | / _| |  _  \      (_)                   ${NOCOLOR}" && sleep .03
	@echo "${YELLOW} ___   ___ | || |_  | | | | _ __  _ __   __ ___  _ __  ${NOCOLOR}" && sleep .03
	@echo "${YELLOW}/ __| / _ \| ||  _| | | | || '__|| |\ \ / // _ \| '_ \ ${NOCOLOR}" && sleep .03
	@echo "${YELLOW}\__ \|  __/| || | _ | |/ / | |   | | \ V /|  __/| | | |${NOCOLOR}" && sleep .03
	@echo "${YELLOW}|___/ \___||_||_|(_)|___/  |_|   |_|  \_/  \___||_| |_|${NOCOLOR}" && sleep .03
	@echo "${YELLOW}                                                       ${NOCOLOR}" && sleep .03
	@# http://patorjk.com/software/taag font doom

remove-containers:
	@echo "${YELLOW}killing containers${NOCOLOR}"
	@docker rm -f nsq-service-self-driven_nsqadmin_1 \
		nsq-service-self-driven_nsqd_1 \
		nsq-service-self-driven_nsqlookupd_1 \
		nsq-service-self-driven_writer_1 \
		nsq-service-self-driven_pyreader_1 \
		nsq-service-self-driven_goreader_1

remove-images:
	@echo "${YELLOW}killing images${NOCOLOR}"
	@docker rmi -f nsq-service-self-driven_writer \
		nsq-service-self-driven_pyreader \
		nsq-service-self-driven_goreader

clean-up: remove-containers remove-images

up: welcome remove-containers compose-up first-message

compose-up:
	@echo "${YELLOW}docker-compose up${NOCOLOR}"
	@docker-compose up -d

status:
	docker-compose ps
	docker-compose logs
	curl http://127.0.0.1:4161/ping
	curl http://127.0.0.1:4151/stats
	@echo "${YELLOW}nsqadmin on:${NOCOLOR}\thttp://localhost:4171/topics/firsttopic"
	@echo "${YELLOW}goreader logs:${NOCOLOR}\tdocker logs -f nsq-service-self-driven_goreader_1"
	@echo "${YELLOW}pyreader logs:${NOCOLOR}\tdocker logs -f nsq-service-self-driven_pyreader_1"

first-message:
	@echo "${YELLOW}Publishing first message and create a topic${NOCOLOR}"
	curl -d "First Message $(shell date +%D) $(shell date +%T)" "localhost:4151/pub?topic=firsttopic"
	@echo "${YELLOW}Creating channels on nsqd${NOCOLOR}"
	curl -X POST "http://127.0.0.1:4151/channel/create?topic=firsttopic&channel=pychann"
	curl -X POST "http://127.0.0.1:4151/channel/create?topic=firsttopic&channel=gochann"
