# Introduction
<img width="50%" height="10%" src="/tojung_green.png"></img>

대한민국 최초의 입법안 크라우드 펀딩 플랫폼 "투정"의 웹사이트 리뉴얼 레포지토리입니다.

웹사이트는: http://2jung.com

## Progress 
> [ 2018.04.06 ~ 2018.04.11 ] 쇼핑몰 형태의 사이트 구현 완료

> [ 2018.04.12 ~ 2018.04.15 ] 사이트 형식에 대한 재검증 및 재기획, 쇼핑몰 형식은 일단 폐기

> [ 2018.04.16 ] 청원&약정 사이트 개발 진행 시작 

> [ 2018.04.17 ~ 2018.04.18 ] 전반적인 백엔드 기능 개발 완료
>> 1. 회원 인증 기능 ( 소셜 로그인,국회의원 회원인증 기능 )
>> 2. 청원 생성, 목록보기, 세부내용보기 기능 및 모델 구축
>> 3. 약정 생성, 소셜 공유 기능 및 모델 구축
>> 4. 커뮤니티 기능

> [ 2018.04.19 ~ 2018.04.23 ] Javascript(Vanilla.js)를 처음 배운후 Vanilla.js만을 이용하여 

> propose/detail 페이지, 무한 스크롤 및 실시간 사이트 구현 완료 및 SPA 구현 시도

> [ 2018.04.24 ] Vanilla.js로 구현한 기능들 보류.

> [ 2018.04.24 ~ 2018.05.02 ] 프론트엔드와 백엔드의 병합 완료 / 사이트 구현 완료

> [ 2018.05.04 ] 비즈니스 로직 변경 및 청원/약정 형식의 사이트 폐기......

## Detail

> 메인 페이지

<img width="50%" height="10%" src="/투정사이트.PNG"></img>

> 로그인 페이지 

<img width="50%" height="10%" src="/투정로그인.PNG"></img>

> 청원 페이지

<img width="50%" height="10%" src="/투정청원.PNG"></img>

> 약정 페이지 

<img width="50%" height="10%" src="/투정약정.PNG"></img>

> 청원 세부 페이지

<img width="50%" height="10%" src="/청원세부.PNG"></img>

> 청원내 커뮤니티 페이지

<img width="50%" height="10%" src="/투정커뮤니티.PNG"></img>

> 청원내 압력넣기 페이지

<img width="50%" height="10%" src="/투정압력넣기.PNG"></img>

> 청원내 명예의 전당 페이지

<img width="50%" height="10%" src="/투정명예전당.PNG"></img>

## Environment

1. 배포 서버 : AWS Elastic Beanstalk 

2. 데이터베이스 서버 : AWS RDS MYSQL 

3. 이미지 저장소 : AWS S3 

## Next ? 
1. SPA + PWA ( Rails Backend + Vue.js Frontend )

2. SPA + PWA + Serverless ( Express.js Backend + Vue.js Frontend + AWS Lambda  )

## Dependency
1. Rails 5

2. ruby 2.4

3. Gem 의존성 관리 : bundle

## LICENSE 
GPL3.0
