# tmux zellij-style manual

기준 파일: [tmux.conf](tmux.conf)

이 설정 목표는 `tmux`를 `zellij`처럼 느끼게 만드는 것이다. 완전히 같지는 않지만, 핵심 사용 흐름은 최대한 비슷하게 맞췄다.

## 핵심 개념

이 설정은 키 입력을 두 층으로 나눈다.

1. `Ctrl-g`
   zellij의 모드 진입 키처럼 쓴다.
   먼저 `Ctrl-g`를 누른 뒤, 다음 키로 모드를 고른다.

2. `Ctrl-b`
   tmux prefix다.
   zellij 흉내를 내는 키맵과 별개로, tmux 원래 바인딩과 긴급 탈출용으로 남겨 둔 키다.

즉, 실사용에서는 이렇게 생각하면 된다.

- `Ctrl-g`: zellij처럼 쓰는 메인 키
- `Ctrl-b`: tmux prefix
- `Ctrl-g ?`: 커스텀 키맵 힌트 팝업
- `Ctrl-g q`: 현재 client detach
- `Ctrl-g Q`: 현재 session 종료 확인

## 빠른 시작

새 tmux 세션을 열면 바로 적용된다.

이미 열려 있는 tmux 세션에 반영하려면:

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

또는 현재 설정상 `Ctrl-b` 다음 `R`:

```text
Ctrl-b R
```

커스텀 키맵 힌트를 빠르게 보고 싶으면:

```text
Ctrl-g ?
```

이 바인딩은 [tmux_keys.txt](tmux_keys.txt) 를 팝업으로 띄운다.

화면 위쪽 status bar 오른쪽에 현재 key table 이름이 보인다.
예:

- `mode:root` = 평소 상태
- `mode:zellij-pane` = pane 모드
- `mode:zellij-tab` = tab 모드

## zellij 식 멘탈 모델

이 설정은 zellij의 "먼저 모드 진입, 그다음 키 입력" 방식을 tmux 안에 옮긴 것이다.

대응 관계는 대략 이렇다.

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
| `Ctrl-g` 후 `Q` | 현재 session kill confirm |

## 항상 먹는 글로벌 키

이 키들은 모드 진입 없이 바로 동작한다.

### 포커스 이동

- `Ctrl-Alt-Left` 또는 `Ctrl-Alt-h`: 왼쪽 pane으로 이동
- `Ctrl-Alt-Right` 또는 `Ctrl-Alt-l`: 오른쪽 pane으로 이동
- `Ctrl-Alt-Up` 또는 `Ctrl-Alt-k`: 위 pane으로 이동
- `Ctrl-Alt-Down` 또는 `Ctrl-Alt-j`: 아래 pane으로 이동

특징:

- 왼쪽 끝에서 왼쪽 이동 시 이전 window로 간다.
- 오른쪽 끝에서 오른쪽 이동 시 다음 window로 간다.
- 위/아래는 window를 넘기지 않는다.

### 새 pane

- `Ctrl-Alt-n`: 현재 경로 기준으로 아래 split

## 모드 진입법

기본 흐름:

```text
Ctrl-g -> p/t/r/s/m/o
```

직행 종료 계열:

```text
Ctrl-g q   -> detach
Ctrl-g Q   -> kill current session (confirm)
```

모드에서 빠져나오기:

- `Enter`
- `Esc`
- `Ctrl-g`

대부분의 "실행형" 동작은 수행 후 자동으로 `root`로 돌아간다.
이 부분도 zellij 사용감과 비슷하게 잡았다.

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

- `e`: zellij의 embed/floating 토글은 tmux에 없음. 안내 메시지만 띄운다.
- `i`: pinned pane 개념 없음.
- `w`: floating pane layer 개념 없음.

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

tmux에서 zellij의 tab은 window에 해당한다.

### 이동

- `h` 또는 `Left`: 이전 tab
- `j` 또는 `Right`: 다음 tab
- `k` 또는 `Up`: 이전 tab
- `l` 또는 `Down`: 다음 tab
- `Tab`: 직전 tab으로 복귀

### 직접 선택

- `1`~`9`: 해당 번호 tab으로 이동

설정상 window index는 `1`부터 시작한다.

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
- 순서 변경: `Ctrl-g t [` / `Ctrl-g t ]`
- 특정 tab 점프: `Ctrl-g t 3`

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

또는 방향키 사용 가능.

### 반대 방향 축소 감각

zellij의 대문자 방향 감각을 흉내 내려고 대문자도 넣어 뒀다.

- `H`
- `J`
- `K`
- `L`

다만 tmux에서는 실제 내부 구현이 pane 경계 이동이라, zellij와 정확히 같은 감각은 아니다.

### 빠져나오기

- `r`: normal launcher 복귀
- `Enter`, `Esc`, `Ctrl-g`: root 복귀

---

## 4. Scroll / Copy 모드

진입:

```text
Ctrl-g s
```

이 키는 바로 tmux `copy-mode`로 들어간다.
바닥까지 내려와도 모드가 자동으로 풀리지 않는다.

### 이동

기본적으로 vi 스타일이다.

- `h j k l`
- 방향키
- `PageUp`, `PageDown`

### 선택 / 복사

- `v`: 선택 시작
- `y`: 선택 복사 후 종료
- `Esc`: copy mode 종료
- `q`: copy mode 종료


클립보드는 `set-clipboard on` 상태라, 터미널/OS 환경이 받쳐주면 시스템 클립보드 연동도 된다.

---

## 5. Move 모드

진입:

```text
Ctrl-g m
```

이 모드는 pane 위치를 실제로 바꾸는 용도다.

### pane swap

- `h j k l`
- 방향키

현재 active pane을 해당 방향의 인접 pane과 swap한다.
swap 이후에도 현재 active pane 포커스는 유지된다.

### rotate

- `n`: rotate down
- `p`: rotate up
- `Tab`: rotate down

### 빠져나오기

- `m`: normal launcher 복귀
- `Enter`, `Esc`, `Ctrl-g`: root 복귀

### 주의

가장자리에서 없는 pane과 swap하려고 하면 tmux 에러 메시지가 잠깐 뜰 수 있다.
정상이다.

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
- `o`: normal launcher 복귀

`x`는 곧바로 현재 session을 죽이는 키가 아니라, chooser를 연 다음 대상 session을 고르게 하는 방식이다.
`X`도 마찬가지로 chooser를 연 뒤 연결 해제할 client를 고른다.

### zellij와 다른 점

아래는 tmux 기본 내장 기능으로는 그대로 못 만든다.

- `a`: about plugin 없음
- `p`: plugin manager UI 없음

그리고 zellij의 session-manager는 하나의 floating UI 안에서 rename, disconnect, kill 같은 기능을 함께 제공하지만,
tmux 쪽은 그걸 `n`, `x`, `X`, `s` 같은 개별 단축키로 근사했다.

---

## tmux 원래 기능 쓰는 법

이 설정은 `Ctrl-b`를 tmux prefix로 둔다.
즉 tmux 기본 흐름도 그대로 쓸 수 있다.

예:

- `Ctrl-b c`: 새 window
- `Ctrl-b x`: pane 닫기
- `Ctrl-b %`: 가로 split
- `Ctrl-b "`: 세로 split

그리고:

- `Ctrl-b R`: `~/.config/tmux/tmux.conf` 다시 로드

## 화면 구성 설명

### 상단 status bar

- 왼쪽: session 이름
- 가운데/왼쪽 영역: tab 목록
- 오른쪽: 현재 key table 이름 + 날짜/시간

### pane border top label

각 pane 위쪽 border에 pane title이 뜬다.

pane title은 다음 상황에서 바뀐다.

- pane rename
- 프로그램이 title을 바꿀 때

## 자주 쓸 실전 시나리오

### 2분할 개발 화면 만들기

```text
Ctrl-g p r
Ctrl-g p d
```

오른쪽 split 한 번, 아래 split 한 번.

### pane만 빠르게 돌아다니기

```text
Ctrl-Alt-h/j/k/l
```

또는:

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

그다음:

- `k/j`로 이동
- `v`로 선택 시작
- `y`로 복사

### 설정 바꾼 뒤 즉시 반영

```text
Ctrl-b R
```

## zellij와 아직 다른 점

다음은 tmux 한계 때문에 완전 복제 불가다.

1. floating panes
2. pinned panes
3. plugin UI
4. zellij의 richer mode/status UX
5. tab/window/pane 배치 철학의 미세한 차이

즉, 이 설정은 "감각"과 "동작 흐름"은 많이 맞췄지만, 기능 모델까지 같게 만든 것은 아니다.

## 문제 생길 때 체크할 것

### `Ctrl-Alt-h/j/k/l`가 안 먹는 경우

원인:

- 터미널이 해당 조합을 다르게 보냄
- macOS terminal emulator 단축키와 충돌

대안:

- `Ctrl-g p h/j/k/l` 사용
- terminal 자체 keybinding 확인


### 리로드했는데 바뀐 것 같지 않은 경우

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

직접 다시 실행해 본다.

### 새 세션부터 완전히 반영하고 싶은 경우

기존 세션 detach 후 새 tmux 세션을 연다.

## 한 줄 요약

평소에는 이렇게 쓰면 된다.

- pane 작업: `Ctrl-g p ...`
- tab 작업: `Ctrl-g t ...`
- resize: `Ctrl-g r ...`
- scroll/copy: `Ctrl-g s`
- move: `Ctrl-g m ...`
- session: `Ctrl-g o ...`
- tmux prefix: `Ctrl-b`
