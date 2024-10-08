script_folder="/Users/angelorg/Documents/Serenity Corporations/Coding/cmake-conan-exp/build"
echo "echo Restoring environment" > "$script_folder/deactivate_conanrunenv-release-armv8.sh"
for v in OPENSSL_MODULES
do
    is_defined="true"
    value=$(printenv $v) || is_defined="" || true
    if [ -n "$value" ] || [ -n "$is_defined" ]
    then
        echo export "$v='$value'" >> "$script_folder/deactivate_conanrunenv-release-armv8.sh"
    else
        echo unset $v >> "$script_folder/deactivate_conanrunenv-release-armv8.sh"
    fi
done


export OPENSSL_MODULES="/Users/angelorg/.conan2/p/b/opens45537b95e53a8/p/lib/ossl-modules"