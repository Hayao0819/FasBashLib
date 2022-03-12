# shellcheck disable=SC2148,SC2034

echo -e "Madoka\nHomura\nSayaka\nMami" | GetArrayIndex "Mami"
echo -e "Hello!\nWorld!" | GetArrayIndex "NoMatchString" || echo
echo -e "Madoka\nHomura\nSayaka\nMami" | GetArrayIndex "Madoka"
