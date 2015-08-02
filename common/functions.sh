## transka - (Very) simple BASH script which allows its user to operate with Transifex translations.
## 
## license: GNU GPLv3
## author: Martin Rotte


# Constants.

# Transifex API.
BASE_API="https://www.transifex.com/api/2"

# Variables.
declare USERNAME
declare PASSWORD
declare SLUG_PROJECT
declare SLUG_RESOURCE

# Check for existence of all dependencies.
#
# Returns EXIT_SUCCESS if all run-time dependencies are met,
# otherwise returns non-zero result.
check_deps() {
  which curl > /dev/null 2>&1
}

get_dependencies_names() {
  echo "curl"
}

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
#
# Arguments:
# $1 - destination file path
download_resource() {
	curl \
		-L --user "$USERNAME":"$PASSWORD" \
		-o "$1" \
		-X GET "$BASE_API/project/$SLUG_PROJECT/resource/$SLUG_RESOURCE/content/?mode=default&file"
}

# Uploads new raw resource content.
#
# Arguments:
# $1 - file path to source resource
upload_resource() {
	curl \
		-L --user "$USERNAME":"$PASSWORD" \
		-X PUT -F "file=@$1" \
		-H "Content-Type: multipart/form-data" "$BASE_API/project/$SLUG_PROJECT/resource/$SLUG_RESOURCE/content/"
}

# Downloads and translation.
#
# Arguments:
# $1 - translation code (e.g. "cs_CZ")
# $2 - destination file path
download_translation() {
	curl \
		-L --user "$USERNAME":"$PASSWORD" \
		-o "$2" \
		-X GET "$BASE_API/project/$SLUG_PROJECT/resource/$SLUG_RESOURCE/translation/$1/?mode=default&file"
}

# Uploads new raw resource translation.
#
# Arguments:
# $1 - translation code (e.g. "cs_CZ")
# $2 - path to translation file
upload_translation() {
	curl \
		-L --user "$USERNAME":"$PASSWORD" \
		-X PUT -F "file=@$2" \
		-H "Content-Type: multipart/form-data" "$BASE_API/project/$SLUG_PROJECT/resource/$SLUG_RESOURCE/translation/$1/"
}