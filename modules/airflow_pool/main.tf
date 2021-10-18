/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  gcloud_cmd_body  = "composer environments run --project=${var.project_id} --location=${var.location} ${var.environment} pool"
  create_cmd_body  = "${local.gcloud_cmd_body} -- --set ${jsonencode(var.name)} ${jsonencode(var.slots)} ${jsonencode(var.description)}"
  destroy_cmd_body = "${local.gcloud_cmd_body} -- --delete ${jsonencode(var.name)}"
}

module "gcloud" {
  source                 = "terraform-google-modules/gcloud/google"
  enabled                = var.enabled
  version                = "3.0.1"
  platform               = "linux"
  create_cmd_entrypoint  = "gcloud"
  create_cmd_body        = local.create_cmd_body
  destroy_cmd_entrypoint = "gcloud"
  destroy_cmd_body       = local.destroy_cmd_body
}
