# File Uploads and Storage

Применять при upload/download, attachments, object storage, S3-compatible storage, local file storage или generated files.

## Validation

Проверять допустимый размер, фактический content type/MIME, extension только как дополнительный сигнал, filename/path normalization и project-specific format validation.

Не доверять одному расширению файла или client-provided MIME.

## Access control

Private file должен проверять право доступа на backend/storage policy. Угадываемый URL не является авторизацией. Signed URLs должны иметь ограниченный срок и минимальные права.

## Storage safety

- не допускать path traversal и произвольную запись;
- генерировать безопасные storage keys вместо доверия исходному filename, если это нужно;
- учитывать collisions и overwrite;
- public/private bucket policy должна соответствовать данным.

## Malicious content

Для проектов, принимающих произвольные файлы от недоверенных пользователей, оценить необходимость antivirus/malware scanning, quarantine, safe preview и запрета опасного inline execution. Scanning не обязателен механически для каждого приложения.

## Lifecycle

Проверять orphaned files при удалении/отмене операции, failed uploads, partial multipart upload, retention и cleanup jobs.

## Verification

Happy upload/download, invalid type/size, permission denied, expired signed URL, delete/cleanup и повторная загрузка одного имени — если применимо.
