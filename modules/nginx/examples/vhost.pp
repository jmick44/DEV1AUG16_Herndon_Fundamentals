nginx::vhost { 'www.ernie.com':
  media_dir => 'rubber_duckie',
}

nginx::vhost { 'www.bert.com':
  asset_dir => 'six',
}



