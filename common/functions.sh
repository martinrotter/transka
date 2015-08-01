## transka - (Very) simple BASH script which allows its user to operate with Transifex translations.
## 
## license: GNU GPLv3
## author: Martin Rotte


# Constants.

# Transifex API.
BASE_API="https://www.transifex.com/api/2"

# Variables.
USERNAME=
PASSWORD=
SLUG_PROJECT=
SLUG_RESOURCE=

# Stores internally project slug.
#
# Arguments:
# $1 - project slug
set_project_slug() {
	SLUG_PROJECT=$1
}

# Stores internally resource slug.
#
# Arguments:
# $1 - resource slug
set_resource_slug() {
	SLUG_RESOURCE=$1
}

# Stores internally username/password.
#
# Arguments:
# $1 - username
# $2 - password
set_credentials() {
	USERNAME=$1
	PASSWORD=$2
}

# Downloads and returns raw text of resource.
download_resource() {
	curl \
		-i -L --user "$USERNAME":"$PASSWORD" \
		-X GET "$BASE_API/project/$SLUG_PROJECT/resource/$SLUG_RESOURCE/content/?mode=default&file"
}

# Uploads new raw resource content.
#
# Arguments:
# $1 - raw resource content (not file path)
upload_resource() {
	curl \
		-i -L --user "$USERNAME":"$PASSWORD" \
		-X PUT "$BASE_API/project/$SLUG_PROJECT/resource/$SLUG_RESOURCE/content/?mode=default&file"
}

# Downloads and returns raw text of translation.
#
# Arguments:
# $1 - translation code (e.g. "cs_CZ")
download_translation() {
	curl \
		-i -L --user "$USERNAME":"$PASSWORD" \
		-X GET "$BASE_API/project/$SLUG_PROJECT/resource/$SLUG_RESOURCE/translation/$1/?mode=default&file"
}

# Uploads new raw resource translation.
#
# Arguments:
# $1 - translation code (e.g. "cs_CZ")
upload_translation() {
	echo $1
}