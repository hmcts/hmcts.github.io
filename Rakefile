require 'middleman-gh-pages'
require 'html-proofer'

ENV["COMMIT_MESSAGE_SUFFIX"] = "[skip ci]"
ENV["BRANCH_NAME"] = "master"

task :check_urls do
    proofer = HTMLProofer.check_directory("./build",
        {
            :check_external_hash => false,
            :ignore_missing_alt => true,
            :ignore_status_codes => [0, 401, 403],
            :ignore_urls =>  [
                # Ignore pulls/branches as these do not translate to raw content
                %r{github\.com/hmcts/(?=.*(?:pull|tree|commit))},
                # This is a url that's generated each time we build the html by tech-docs-gem but does not exist
                %r{https://github.com/hmcts/hmcts.github.io/blob/master/source/search/index.html}
            ]
        })

    token = ENV.fetch('GH_TOKEN', nil)
    proofer.before_request do |request|
        if request.base_url.include?("https://github.com/hmcts/")
            request.options[:headers]["Authorization"] = "Bearer #{token}"
            base_url_parts = request.base_url.split('/')
            # 5 parts is if we're just querying a repo itself - which needs a generic file added to the URl
            # to check the repo exists
            if base_url_parts.length == 5 && !request.base_url.include?('#')
                request.base_url = request.base_url.gsub("github.com", "raw.githubusercontent.com")
                request.base_url += "/source/README.md"
            # Checking for blob is to convert URLs pointing to files
            elsif request.base_url.include?("/blob/")
                request.base_url = request.base_url.gsub("/blob", "")
                request.base_url = request.base_url.gsub("github.com", "raw.githubusercontent.com")
            end
        end
    end
    # Run HTML Proofer against built HTML files
    proofer.run
end