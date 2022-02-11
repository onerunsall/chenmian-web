#!/bin/bash
echo "admin : asdfj12#!@jweoiqr$@1482DF3ewrjOY"
echo

domain=chenmian
project=mumu
domainPath=/root/data/domains/za

versionNote=$1
if [ -z "$versionNote" ]; then
 versionNote='pack 更新'
fi


echo "-assign version"
version=`date +%y%m%d%H`
echo version: $version
echo

echo "-package"
commitId=`git rev-parse --short HEAD`
packageName="$domain-$project-web-$version-$commitId.zip"
echo $packageName
cd ./src
../zip -q -r ../packages/$packageName ./
cd ..
echo

echo "-git add"
git add .
echo

echo "-git commit"
git commit -am "$versionNote"
echo

echo "-git push"
git push

echo "-remote push"
scp -P 33699 ./packages/$packageName admin@47.110.157.60:$domainPath
echo

echo "-remote deploy"
ssh -p 33699 -t admin@47.110.157.60 "unzip -q -o $domainPath/$packageName -d $domainPath/webroot/$project"
echo

start https://njshangka.com/home

echo success
