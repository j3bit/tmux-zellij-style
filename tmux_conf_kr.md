# tmux zellij-style 매뉴얼

기준 파일: [tmux.conf](tmux.conf)

이 설정의 목표는 `tmux`를 `zellij`처럼 느껴지게 만드는 것입니다. 완전히 같은 도구로 바꾸는 것은 아니지만, 자주 쓰는 흐름과 손에 익는 조작 방식은 최대한 비슷하게 맞추었습니다.

## 핵심 개념

이 설정은 키 입력을 두 층으로 나눕니다.

1. `Ctrl-g`
   zellij의 모드 진입 키처럼 사용하는 메인 런처입니다. 먼저 `Ctrl-g`를 누른 뒤, 다음 키로 원하는 모드를 고르시면 됩니다.

2. `Ctrl-b`
   tmux 기본 prefix입니다. zellij 스타일 키맵과 별개로, tmux 원래 바인딩과 비상 탈출용 동작을 그대로 남겨 두었습니다.

실제로는 아래처럼 이해하시면 됩니다.

- `Ctrl-g`: zellij처럼 쓰는 메인 키
- `Ctrl-b`: tmux 기본 prefix
- `Ctrl-g ?`: 커스텀 키맵 힌트 팝업
- `Ctrl-g q`: 현재 client detach
- `Ctrl-g Q`: 현재 session 종료 확인

## 빠른 시작

새 tmux 세션을 열면 설정이 바로 적용됩니다.

테마는 `~/.config/tmux/theme/current.conf`가 있으면 그 파일을 먼저 읽고, 없으면 기본값으로 `~/.config/tmux/theme/one-half-dark.conf`를 읽습니다.

이미 열려 있는 tmux 세션에 다시 반영하려면 아래 명령을 실행하시면 됩니다.

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

또는 session 모드로 들어가서 `r`을 누르셔도 됩니다.

```text
Ctrl-g o r
```

커스텀 키맵 힌트를 빠르게 보시려면 아래 키를 누르시면 됩니다.

```text
Ctrl-g ?
```

이 바인딩은 [tmux_keys.txt](tmux_keys.txt)를 팝업으로 띄웁니다.

화면 위쪽 status bar 오른쪽에는 현재 key table 이름이 표시됩니다.

- `mode:root`: 평상시 상태
- `mode:zellij-pane`: pane 모드
- `mode:zellij-tab`: tab 모드

## zellij식 멘탈 모델

이 설정은 zellij의 "먼저 모드에 들어간 뒤, 그 안에서 동작을 고른다"는 흐름을 tmux 안으로 옮긴 것입니다.

대응 관계는 대략 아래와 같습니다.

| zellij 느낌 | tmux 설정 |
| --- | --- |
| `Ctrl-g` 후 `p` | pane 모드 |
| `Ctrl-g` 후 `t` | tab 모드 |
| `Ctrl-g` 후 `r` | resize 모드 |
| `Ctrl-g` 후 `s` | scroll/copy 모드 |
| `Ctrl-g` 후 `m` | move 모드 |
| `Ctrl-g` 후 `o` | session 모드 |
| `Ctrl-g` 후 `?` | 커스텀 키맵 힌트 팝업 |
| `Ctrl-g` 후 `q` | 현재 client detach |
| `Ctrl-g` 후 `Q` | 현재 session 종료 확인 |

## 항상 동작하는 글로벌 키

이 키들은 별도의 모드 진입 없이 바로 동작합니다.

### 포커스 이동

- `Ctrl-Alt-Left` 또는 `Ctrl-Alt-h`: 왼쪽 pane으로 이동
- `Ctrl-Alt-Right` 또는 `Ctrl-Alt-l`: 오른쪽 pane으로 이동
- `Ctrl-Alt-Up` 또는 `Ctrl-Alt-k`: 위 pane으로 이동
- `Ctrl-Alt-Down` 또는 `Ctrl-Alt-j`: 아래 pane으로 이동

동작 특성은 아래와 같습니다.

- 왼쪽 끝에서 왼쪽으로 이동하면 이전 window로 넘어갑니다.
- 오른쪽 끝에서 오른쪽으로 이동하면 다음 window로 넘어갑니다.
- 위아래 이동은 window를 넘기지 않습니다.

### 새 pane 만들기

- `Ctrl-Alt-n`: 현재 경로 기준으로 아래쪽 split
- `Ctrl-Alt-r`: 현재 경로 기준으로 오른쪽 split

## 모드 진입 방법

기본 흐름은 아래와 같습니다.

```text
Ctrl-g -> p/t/r/s/m/o
```

바로 실행되는 종료 계열 단축키는 아래와 같습니다.

```text
Ctrl-g q   -> detach
Ctrl-g Q   -> kill current session (confirm)
```

모드에서 빠져나올 때는 아래 키를 사용하시면 됩니다.

- `Enter`
- `Esc`
- `Ctrl-g`

대부분의 실행형 동작은 수행이 끝난 뒤 자동으로 `root` 상태로 돌아갑니다. 이 부분도 zellij 사용감과 비슷하게 맞춰 두었습니다.

---

## 1. Pane 모드

진입:

```text
Ctrl-g p
```

### 이동

- `h j k l`
- 방향키 `← ↓ ↑ →`
- `Tab`: 직전 pane으로 이동

### 작업

- `c`: 현재 pane 제목 변경
- `d`: 아래로 split
- `n`: 아래로 split
- `r`: 오른쪽으로 split
- `f`: 현재 pane zoom 토글
- `s`: tiled layout으로 정렬
- `x`: 현재 pane 닫기
- `z`: pane border title 표시 토글
- `p`: pane 모드에서 normal launcher로 복귀

### zellij와 다른 점

- `e`: zellij의 embed/floating 토글은 tmux에 없어서 안내 메시지만 표시합니다.
- `i`: pinned pane 개념이 없습니다.
- `w`: floating pane layer 개념이 없습니다.

### 추천 사용 패턴

- 분할: `Ctrl-g p d` 또는 `Ctrl-g p r`
- pane 이동: `Ctrl-g p h/j/k/l`
- 전체 확대: `Ctrl-g p f`
- pane 닫기: `Ctrl-g p x`

---

## 2. Tab 모드

진입:

```text
Ctrl-g t
```

tmux에서는 zellij의 tab 개념이 window에 대응합니다.

### 이동

- `h` 또는 `Left`: 이전 tab
- `j` 또는 `Right`: 다음 tab
- `k` 또는 `Up`: 이전 tab
- `l` 또는 `Down`: 다음 tab
- `Tab`: 직전 tab으로 복귀

### 직접 선택

- `1`부터 `9`: 해당 번호 tab으로 이동

설정상 window index는 `1`부터 시작합니다.

### 작업

- `n`: 새 tab 생성
- `r`: 현재 tab 이름 변경
- `x`: 현재 tab 닫기
- `s`: synchronize-panes 토글
- `b`: 현재 pane을 새 tab으로 분리
- `[`: 현재 tab을 왼쪽으로 이동
- `]`: 현재 tab을 오른쪽으로 이동
- `t`: tab 모드에서 normal launcher로 복귀

### 추천 사용 패턴

- 새 tab: `Ctrl-g t n`
- 이름 변경: `Ctrl-g t r`
- 순서 변경: `Ctrl-g t [` 또는 `Ctrl-g t ]`
- 특정 tab으로 이동: `Ctrl-g t 3`

---

## 3. Resize 모드

진입:

```text
Ctrl-g r
```

### 크기 조절

- `h`: 왼쪽으로 넓힘
- `j`: 아래로 넓힘
- `k`: 위로 넓힘
- `l`: 오른쪽으로 넓힘

방향키로도 동일하게 조절하실 수 있습니다.

### 반대 방향 축소 느낌

zellij의 대문자 방향 감각을 흉내 내기 위해 대문자도 넣어 두었습니다.

- `H`
- `J`
- `K`
- `L`

다만 tmux에서는 실제 구현이 pane 경계를 움직이는 방식이라, zellij와 완전히 같은 느낌은 아닙니다.

### 빠져나오기

- `r`: normal launcher로 복귀
- `Enter`
- `Esc`
- `Ctrl-g`

---

## 4. Scroll / Copy 모드

진입:

```text
Ctrl-g s
```

이 키는 바로 tmux `copy-mode`로 들어갑니다. 끝까지 스크롤하더라도 모드가 자동으로 종료되지는 않습니다.

### 이동

기본 조작은 vi 스타일입니다.

- `h j k l`
- 방향키
- `PageUp`
- `PageDown`

### 선택 / 복사

- `v`: 선택 시작
- `y`: 선택 복사 후 종료
- `Esc`: copy mode 종료
- `q`: copy mode 종료

`set-clipboard on`이 켜져 있으므로, 터미널과 운영체제 환경이 받쳐주면 시스템 클립보드와도 연동됩니다.

---

## 5. Move 모드

진입:

```text
Ctrl-g m
```

이 모드는 pane 위치를 실제로 바꾸고 싶을 때 사용합니다.

### pane swap

- `h j k l`
- 방향키

현재 활성 pane을 해당 방향의 인접 pane과 맞바꿉니다. swap 이후에도 현재 active pane 포커스는 유지됩니다.

### rotate

- `n`: rotate down
- `p`: rotate up
- `Tab`: rotate down

### 빠져나오기

- `m`: normal launcher로 복귀
- `Enter`
- `Esc`
- `Ctrl-g`

### 주의할 점

가장자리에서 존재하지 않는 pane과 swap하려고 하면 tmux 에러 메시지가 잠깐 보일 수 있습니다. 정상 동작입니다.

---

## 6. Session 모드

진입:

```text
Ctrl-g o
```

### 작업

- `d`: detach
- `n`: 현재 session 이름 변경
- `r`: `~/.config/tmux/tmux.conf` 리로드
- `s`: session chooser
- `w`: window/session tree chooser
- `x`: session chooser를 열고 선택한 session 종료
- `X`: client chooser를 열고 선택한 client 연결 해제
- `?`: 커스텀 키맵 힌트 팝업
- `c`: 설정 편집/리로드 안내 메시지
- `o`: normal launcher로 복귀

`x`는 현재 session을 즉시 종료하는 키가 아니라, chooser를 연 뒤 대상을 고르게 하는 방식입니다. `X`도 마찬가지로 chooser를 연 뒤 연결을 해제할 client를 고르게 됩니다.

### zellij와 다른 점

아래 기능은 tmux 기본 내장 기능만으로는 그대로 만들 수 없습니다.

- `a`: about plugin 없음
- `p`: plugin manager UI 없음

또한 zellij의 session manager는 하나의 floating UI 안에서 rename, disconnect, kill 같은 기능을 함께 제공하지만, tmux 쪽은 이를 `n`, `x`, `X`, `s` 같은 개별 단축키 조합으로 근사했습니다.

---

## tmux 원래 기능 쓰는 법

이 설정은 `Ctrl-b`를 tmux 기본 prefix로 유지합니다. 따라서 tmux 원래 흐름도 그대로 쓰실 수 있습니다.

예를 들면 아래와 같습니다.

- `Ctrl-b c`: 새 window
- `Ctrl-b x`: pane 닫기
- `Ctrl-b %`: 가로 split
- `Ctrl-b "`: 세로 split
## 화면 구성 설명

### 상단 status bar

- 왼쪽: session 이름
- 가운데 또는 왼쪽 영역: tab 목록
- 오른쪽: 현재 key table 이름과 날짜/시간

### pane border 상단 라벨

각 pane 위쪽 border에는 pane title이 표시됩니다.

pane title은 아래 상황에서 바뀔 수 있습니다.

- pane 이름을 직접 바꿨을 때
- 실행 중인 프로그램이 title을 바꿨을 때

## 자주 쓰는 실전 시나리오

### 2분할 개발 화면 만들기

```text
Ctrl-g p r
Ctrl-g p d
```

오른쪽으로 한 번 분할하고, 아래로 한 번 더 분할합니다.

### pane 사이를 빠르게 이동하기

```text
Ctrl-Alt-h/j/k/l
```

또는 아래처럼 pane 모드에서 이동하셔도 됩니다.

```text
Ctrl-g p h/j/k/l
```

### tab 여러 개 열고 이동하기

```text
Ctrl-g t n
Ctrl-g t n
Ctrl-g t 1
Ctrl-g t 2
```

### 현재 pane 로그 복사하기

```text
Ctrl-g s
```

그다음 아래 순서로 진행하시면 됩니다.

- `k` 또는 `j`로 이동
- `v`로 선택 시작
- `y`로 복사

### 설정 바꾼 뒤 즉시 반영하기

```text
Ctrl-g o r
```

## zellij와 아직 다른 점

아래 항목은 tmux 한계 때문에 완전히 동일하게 재현할 수 없습니다.

1. floating panes
2. pinned panes
3. plugin UI
4. zellij의 더 풍부한 mode/status UX
5. tab, window, pane 배치 철학의 미세한 차이

즉, 이 설정은 사용감과 동작 흐름은 많이 맞췄지만, 기능 모델 자체를 zellij와 똑같이 만든 것은 아닙니다.

## 문제 생길 때 확인할 것

### `Ctrl-Alt-h/j/k/l`가 동작하지 않는 경우

가능한 원인은 아래와 같습니다.

- 터미널이 해당 조합을 다른 키 시퀀스로 보낼 때
- macOS 터미널 에뮬레이터 단축키와 충돌할 때

대안은 아래와 같습니다.

- `Ctrl-g p h/j/k/l` 사용
- 터미널 자체 keybinding 설정 확인

### 리로드했는데 바뀐 것 같지 않은 경우

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

위 명령을 직접 다시 실행해 보시면 됩니다.

### 테마를 바꾸고 싶은 경우

가장 단순한 방법은 `theme/current.conf`를 원하는 테마 파일로 연결하는 것입니다.

```bash
ln -sf ~/.config/tmux/theme/dracula.conf ~/.config/tmux/theme/current.conf
tmux source-file ~/.config/tmux/tmux.conf
```

### 새 세션부터 완전히 반영하고 싶은 경우

기존 세션을 detach한 뒤 새 tmux 세션을 열어 보시면 됩니다.

## 한 줄 요약

평소에는 아래처럼 기억하시면 충분합니다.

- pane 작업: `Ctrl-g p ...`
- tab 작업: `Ctrl-g t ...`
- resize: `Ctrl-g r ...`
- scroll/copy: `Ctrl-g s`
- move: `Ctrl-g m ...`
- session: `Ctrl-g o ...`
- tmux prefix: `Ctrl-b`
