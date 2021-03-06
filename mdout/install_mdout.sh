#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#================================================#
# 系统要求: CentOS | Red-Hat | Darwin | Ubuntu    #
# 描述: 一键安装 Markdown to PDF (mdout by jabin)  #
# 作者: Fisher                                    #
# 联系方式: wz2483156090@gmail.com                #
#================================================#

clear
echo -e "\033[34m================================================================\033[0m

            欢迎使用 Markdown to PDF (mdout by jabin) 一键安装脚本

            系统要求: CentOS | Red-Hat | Darwin | Ubuntu
            描述: 一键安装 Markdown to PDF (mdout by jabin)
            作者: Fisher
            联系方式： wz2483156090@gmail.com

\033[34m================================================================\033[0m"
echo

# 全局变量
# 下载地址
DOWNLOAD_URL_LINUX="http://112.74.177.253:8000/f/edcb3b9e460d4d18ab3f/?dl=1"
DOWNLOAD_URL_DARWIN="http://112.74.177.253:8000/f/100873c74622474da4d9/?dl=1"
DOWNLOAD_URL_WIN="http://112.74.177.253:8000/f/574b3d14ffe04bb1880b/?dl=1"
# 检查用户是否安装wget或curl: 0->安装了wget | 1->安装了curl | 2->2个都没有装
TOOL_TYPE=
# 系统信息: 0->Linux | 1->Darwin | 2->Ubuntu
OS_TYPE=
# 用户名称
USER_NAME=

function checkTool() {
	echo -e "\033[33m 检查依赖工具包...... \033[0m"
	if [ -x "$(command -v wget)" ]; then
		TOOL_TYPE=0
		echo -e "\033[32m wget 已安装, 检查通过! \033[0m"
	elif [ -x "$(command -v curl)" ]; then
		TOOL_TYPE=1
		echo -e "\033[32m curl 已安装, 检查通过! \033[0m"
	else
		TOOL_TYPE=2
		echo -e "\033[31m 此脚本需要 wget 或者 curl , 请先安装 wget 或 curl \033[0m"
		exit 1
	fi
}

# 检查用户, 记录用户名
function checkUser() {
	echo -e "\033[33m 检查用户...... \033[0m"
	USER_NAME=$USER
	echo -e "\033[32m 用户检查完成, 当前用户: $USER_NAME \033[0m"
}

# 检查系统版本
function checkOS() {
	echo -e "\033[33m 检查系统版本...... \033[0m"
	OS_VERSION=`uname`
	if [[ $OS_VERSION == "Linux" ]]; then
		OS_TYPE=0
		THEME_HOME="/home/$USER_NAME/binmdout"
	elif [[ $OS_VERSION == "Darwin" ]]; then
		OS_TYPE=1
		THEME_HOME="/Users/$USER_NAME/binmdout"
	else
		echo -e "\033[31m 错误: 本脚本不支持此系统 \033[0m"
		exit 1
	fi
	echo -e "\033[32m 检查完成, 你的系统为: $OS_VERSION -> OS_TYPE: $OS_TYPE \033[0m"
}

# 下载Markdown to PDF程序包
function downloadProgram() {
	echo -e "\033[33m 开始下载 Markdown to PDF (mdout by jabin) 程序包...... \033[0m"
	# 系统为Darwin
	if [[ $OS_TYPE -eq 1 ]]; then
		# 工具为wget
		if [[ $TOOL_TYPE -eq 0 ]]; then
			if ! wget --no-check-certificate -O mdout.tar.gz -c $DOWNLOAD_URL_DARWIN; then
				echo -e "\033[31m 下载 Markdown to PDF (mdout by jabin) 文件失败,请检查网络状态. \033[0m"
				exit 1
			fi
		# 工具为curl
		else
			if ! curl -o mdout.tar.gz $DOWNLOAD_URL_DARWIN; then
				echo -e "\033[31m 下载 Markdown to PDF (mdout by jabin) 文件失败,请检查网络状态. \033[0m"
				exit 1
			fi
		fi
	# 系统为Linux
	else
		# 工具为wget
		if [[ $TOOL_TYPE -eq 0 ]]; then
			if ! wget --no-check-certificate -O mdout.tar.gz -c $DOWNLOAD_URL_LINUX; then
				echo -e "\033[31m 下载 Markdown to PDF (mdout by jabin) 文件失败,请检查网络状态. \033[0m"
				exit 1
			fi
		# 工具为curl
		else
			if ! curl -o mdout.tar.gz $DOWNLOAD_URL_LINUX; then
				echo -e "\033[31m 下载 Markdown to PDF (mdout by jabin) 文件失败,请检查网络状态. \033[0m"
				exit 1
			fi
		fi
	fi
	echo -e "\033[32m 下载 Markdown to PDF (mdout by jabin) 完成 \033[0m"
}

# 解压安装mdout.tar.gz
function installProgram() {
	echo -e "\033[33m 开始安装 Markdown to PDF (mdout by jabin) ...... \033[0m"
	tar zxvf mdout.tar.gz && rm mdout.tar.gz
	# 在Linux系统下添加到环境变量需要root权限
	if [[ $OS_TYPE -eq 1 ]]; then
		mv ./mdout /usr/local/bin
	else
		echo -e "\033[33m 在Linux下将 Markdown to PDF (mdout by jabin) 添加到环境变量需要root用户密码, 请在下方输入 \033[0m"
		sudo mv ./mdout /usr/local/bin
	fi
	# mdout初始化
	if ! mdout install; then
		echo -e "\033[31m 执行mdout初始化失败, 请在后续自行初始化 \033[0m"
	fi
	echo -e "\033[32m 安装 Markdown to PDF (mdout by jabin) 完成 \033[0m"
}

# 输出安装信息
function showInfo() {
	echo
	echo -e "\033[34m================================================================\033[0m"
	echo
	echo -e "\033[32m 安装完成, 可直接通过mdout运行, 安装信息如下 \033[0m"
	echo -e "\033[32m mdout主程序安装在以下目录: /usr/local/bin \033[0m"
	echo -e "\033[32m mdout主题包安装在以下目录: $THEME_HOME \033[0m"
	echo
	echo -e "\033[34m================================================================\033[0m"
}

# 主程序执行顺序
checkTool
checkUser
checkOS
downloadProgram
installProgram
showInfo