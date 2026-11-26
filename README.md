# antigravity

Google Antigravity에서 여러 컴퓨터에 걸쳐 공통으로 쓰는 전역 규칙과 커스터마이징 원본 저장소입니다. 특정 회사나 프로젝트에 묶이지 않는 범용 설정만 담습니다.

## 설치 및 사용법

```bash
git clone https://github.com/wisehero/antigravity.git
cd antigravity
bash install.sh
```

- `install.sh`는 `~/.gemini/config/GEMINI.md`로 심볼릭 링크를 연결합니다.
- 기존 파일이 이미 있으면 `~/.gemini/backups/` 아래에 타임스탬프 폴더로 백업한 뒤 연결합니다.
- 규칙을 수정할 때는 이 저장소의 파일을 수정하고 커밋·푸시합니다. 다른 컴퓨터에서는 `git pull`만 받으면 바로 반영됩니다.

## 구성

| 경로 | 링크 위치 | 설명 |
|---|---|---|
| `config/GEMINI.md` | `~/.gemini/config/GEMINI.md` | 전역 규칙 (윤문·리라이팅 톤 프리셋 및 사실 보존 기준) |
| `install.sh` | - | 전역 설정 심볼릭 링크 설치 스크립트 |

## 담지 않는 것

- 회사·프로젝트 전용 규칙, 스킬, 운영 스크립트
- API 키, 토큰, 계정 정보 등 비밀값
