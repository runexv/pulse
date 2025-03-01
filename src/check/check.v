module check

import os

// check curl installation and install if needed
pub fn ensure_curl_installed() bool {
    curl := os.execute('curl --version')
    if curl.exit_code == 0 && curl.output.contains('Release-Date') {
        return true
    }

    if curl.exit_code != 0 && curl.output.contains('not') && curl.output.contains('command') {
        println('curl is not installed. installing...')
        match os.user_os() {
            'windows' { println('please install curl manually') }
            'linux' {
                os.execute('sudo apt-get install curl -y')
                return true
            }
            'macos' {
                os.execute('brew install curl')
                return true
            }
            else { println('unsupported operating system') }
        }
    }
    return false
}

// check website accessibility and status
pub fn check_website(link string) {
    if !ensure_curl_installed() {
        println('error: curl is required but not available')
        return
    }

    // define valid status codes and their meanings
    status_meanings := {
        '200': 'ok',
        '201': 'created',
        '202': 'accepted',
        '203': 'non-authoritative info',
        '204': 'no content',
        '205': 'reset content',
        '206': 'partial content',
        '301': 'permanent redirect',
        '302': 'temporary redirect',
        '303': 'see other',
        '304': 'not modified',
        '307': 'temporary redirect',
        '308': 'permanent redirect'
    }

    result := os.execute('curl -s -o /dev/null -w "%{http_code}" $link')
    status := result.output
    is_working := status in status_meanings.keys()

    if is_working {
        status_text := status_meanings[status] or { 'unknown' }
        println('\x1b[32m👍 website is working (status: ${status} "${status_text}")\x1b[0m')
    } else {
        println('\x1b[31m❌ website is not accessible (status: ${status})\x1b[0m')
    }
}
