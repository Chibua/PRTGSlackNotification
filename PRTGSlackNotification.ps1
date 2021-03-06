# ----------------------------------------------------------------------------------------------
# Copyright (c) WCOM AB 2015.
# ----------------------------------------------------------------------------------------------
# This source code is subject to terms and conditions of the The MIT License (MIT)
# copy of the license can be found in the LICENSE file at the root of this distribution.
# ----------------------------------------------------------------------------------------------
# You must not remove this notice, or any other, from this software.
# ----------------------------------------------------------------------------------------------
Param(
    [string]$SlackToken,
    [string]$SlackChannel,
    [string]$SiteName,
    [string]$Device,
    [string]$Name,
    [string]$Status,
    [string]$Down,
    [string]$DateTime,
    [string]$LinkDevice,
    [string]$Message
)
$postSlackMessage = @{
    token        = $SlackToken;
    channel      = $SlackChannel;
    unfurl_links = "true";
    username     = "PRTG";
    icon_url     = "http://www.paessler.com/static/banner_1s_80x80.png"
    text         = "*$($sitename)*
<$($LinkDevice)|$($Device) $($Name)>
Status $($Status) $($Down) on $($DateTime)
``````$($Message)``````";
    }
$postSlackMessage | Out-File -FilePath slack.log
$postSlackMessage.text  | Out-File -FilePath slack.log -Append
Invoke-RestMethod -Uri https://slack.com/api/chat.postMessage -Body $postSlackMessage | Out-File -FilePath slack.log -Append
