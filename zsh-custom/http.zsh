# ```sh
# curl -v -H "Origin: http://local-dashboard.boosterthon.com" -X GET \
#   https://funrun-dev.s3.amazonaws.com/user_profile_images/a1667e901fdc63e8013a06d583fa1076.jpeg > /dev/null
# ```

# ```
# curl -H "Origin: http://local-dashboard.boosterthon.com" --verbose \
#   https://funrun-dev.s3.amazonaws.com/user_profile_images/a1667e901fdc63e8013a06d583fa1076.jpeg > /dev/null
# ```

# ```sh
# curl -H "Access-Control-Request-Method: GET" -H "Origin: http://local-dashboard.boosterthon.com" \
#   --head https://funrun-dev.s3.amazonaws.com/user_profile_images/a1667e901fdc63e8013a06d583fa1076.jpeg
# ```


# curl -H "Access-Control-Request-Method: GET" -H "Origin: http://local-dashboard.boosterthon.com" \
#   -I https://funrun-dev.s3.amazonaws.com/user_profile_images/a1667e901fdc63e8013a06d583fa1076.jpeg