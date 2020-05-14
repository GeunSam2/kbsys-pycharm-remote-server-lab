# PyCharm remote server

*본 글은 PyCharm Enterprise, Docker를 활용하였으며,
본 문서의 기능을 테스트하기 위해서는 PyCharm Enterprise의 기능이 필요합니다.*

---

# Server Setting

### 필요요소

- Docker가 설치된 리눅스 서버

> 본래 PyCharm remote server의 기능을 이용하기 위해서는 `SSH서버`, `python 인터프리터` 만 정상적으로 설치되고 실행 된다면 상관없다. 하지만 본 내용은 해당 기능을 간편하게 테스트 해보기 위한 자료로, 미리 구성 된 환경을 이용하기 위해 Docker가 필요하다. 

### Python server 환경 실행

다음 도커 명령어를 실행하여 미리 구성된 파이썬 환경을 구동한다. 해당 도커 이미지에는 SSH서버, Django 프레임워크를 비롯하여 기본적인 Django 웹 서버를 구동할수 있는 환경이 구성되어 있다.

```docker
docker run -dit -p 2222:22 -p 8888:80 --rm --name pycharm-test geunsam2/django:test
```

> 22포트 : SSH 서버
> 80포트 : Django 웹서버 이다.
> 위의 예시 명령어를 통해 외부로 노출되는 포트는 `2222` , `8888` 이므로 본인의 포트 여유 상황에 맞게 명령어를 수정하여 실행할 수 있다.
> (위의 포트들을 변경하여 실행하게 되면, 이후 진행되는 실습에서 본인이 수정한 포트를 적용하여 실습해야 한다.)

### 구동 확인

```docker
#bash

docker logs pycharm-test
```

컨테이너가 정상적으로 구동 되었다면 다음과 같은 출력이 나온다.

```docker
#출력예시

Performing system checks...

System check identified no issues (0 silenced).
May 14, 2020 - 11:26:12
Django version 1.8.2, using settings 'sample.settings'
Starting development server at http://0:80/
Quit the server with CONTROL-C.
```

테스트 페이지에 직접 접속하여 확인도 가능하다.

- 접속 url :  `http://<server-ip>:8888`
- 테스트용 서버 : [http://220.70.71.231:8888/](http://220.70.71.231:8888/)

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled.png)

여기까지 되었다면, 서버쪽 테스트 준비가 완료되었다.

# Client Setting

### 환경세팅

원격 서버의 인터프리터를 사용할 프로젝트를 생성 한다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%201.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%201.png)

아래 이미지를 이용하여 새로운 인터프리터 생성을 진행한다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%202.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%202.png)

SSH Interpreter를 선택하고, 표시 된 부분에 값을 입력한다.

- `Host`: Remote Server의 IP주소 (테스트서버: 220.70.71.231)
- `Port`: Remote Server의 SSH 포트 (테스트서버: 2233)
- `Username`: Remote Server의 SSH 유저이름 (테스트서버: root)

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%203.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%203.png)

처음 접속시 키교환을 위한 경고 메시지가 뜨면 Yes를 클릭한다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%204.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%204.png)

Password에 ssh 접속 암호(테스트서버: `test1234` )를 입력한다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%205.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%205.png)

대상 서버의 사용할 python 인터프리터의 경로를 지정한다.
(Execute code using this interpreter with root privileges via sudo에는 체크하지 않는다.)

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%206.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%206.png)

인터프리터 부분이 바뀐것을 확인하고, `Remote project location` 에 프로젝트가 존재하거나 위치시킬 경로(테스트서버: `/project` )를 입력하고 Create를 누른다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%207.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%207.png)

방화벽 관련한 경고 메시지가 뜨면, 아래와 같이 클릭하고, `Contigure Automatically`를 선택한다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%208.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%208.png)

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%209.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%209.png)

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2010.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2010.png)

아래와 같이 프로젝트 폴더에서 오른쪽 마우스 → Deployment → Sync with Deployed... 기능을 이용하여 원격 서버의 소스와 로컬 소스를 동기화 한다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2011.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2011.png)

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2012.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2012.png)

PyCharm에서 수정한 내용을 서버에 자동으로 동기화 시키기 위해 다음 설정을 한다.

Tools → Deployment → Automatic Upload (always)를 선택한다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2013.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2013.png)

자동 업로드 설정까지 완료되면, 환경세팅은 완료되었다.

### 구동 확인

sample → pycharmtest → views.py 파일의 내용을 수정하고 저장(ctrl+s) 해본다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2014.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2014.png)

```docker
#views.py

from django.http import HttpResponse

def index(request):
    #Edit here
    return HttpResponse("Edit Success!!")
```

웹페이지를 갱신하여 수정사항이 반영된 것을 확인한다.

![PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2015.png](PyCharm%20remote%20server%20e4a755ec8b6743d09a279d37625be559/Untitled%2015.png)

*EOF*