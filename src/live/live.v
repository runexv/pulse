module live

import os
import time
import check

// monitors a website for changes in availability
pub fn monitor_website(link string, refresh_interval int) {
    // ensure curl is available
    if !check.ensure_curl_installed() {
        println('error: curl is required but not available')
        return
    }

    // define valid status codes and their meanings - same as in check module
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

    // initial check
    result := os.execute('curl -s -o /dev/null -w "%{http_code}" $link')
    mut previous_status := result.output
    mut was_accessible := previous_status in status_meanings.keys()

    // display initial status
    if was_accessible {
        if previous_status == '200' {
            println('\x1b[32m👍 the website is up and working (status: 200 "${status_meanings['200']}")\x1b[0m')
        } else {
            println('\x1b[32m👍 the website is working (status: ${previous_status} "${status_meanings[previous_status]}")\x1b[0m')
        }
    } else {
        println('\x1b[31m❌ the website is not accessible (status: ${previous_status})\x1b[0m')
    }

    // monitoring loop
    for {
        // wait for the specified interval
        time.sleep(refresh_interval * time.second)
        
        // check website status
        current_result := os.execute('curl -s -o /dev/null -w "%{http_code}" $link')
        current_status := current_result.output
        is_accessible := current_status in status_meanings.keys()
        
        // only report if status changed
        if is_accessible != was_accessible {
            if is_accessible {
                println('\x1b[34m❕👍 the website is now accessible (status: ${current_status})\x1b[0m')
            } else {
                println('\x1b[34m❕❌ the website is no longer accessible (status: ${current_status})\x1b[0m')
            }
            
            // update previous state
            was_accessible = is_accessible
            previous_status = current_status
        }
    }
}