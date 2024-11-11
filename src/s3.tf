
resource "yandex_iam_service_account" "db-viewer" {
  name = "db-viewer"
}

data "yandex_iam_service_account" "ter" {
  name = "ter"
}


resource "yandex_resourcemanager_folder_iam_member" "db-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.db-viewer.id}"
  depends_on = [ yandex_iam_service_account.db-viewer ]
}


resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "${yandex_iam_service_account.db-viewer.id}"
  depends_on = [ yandex_iam_service_account.db-viewer ]
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "terteryan" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "terteryan"
  depends_on = [ yandex_iam_service_account_static_access_key.sa-static-key ]

  anonymous_access_flags {
    read = true
    list = false
    config_read = true
  }
  
}