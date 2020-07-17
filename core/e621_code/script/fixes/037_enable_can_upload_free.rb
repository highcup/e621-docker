#!/usr/bin/env ruby

require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'config', 'environment'))

ActiveRecord::Base.connection.execute("set statement_timeout = 0")

CurrentUser.user = User.admins.first
CurrentUser.ip_addr = "127.0.0.1"

User.where("level >= ?", 33).find_each do |user|
  user.can_upload_free = true
  user.level = User::Levels::JANITOR if user.level == 35
  user.save
end
