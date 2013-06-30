class PaginatingDecorator < Draper::CollectionDecorator
  # support for will_paginate
  delegate :current_page, :per_page, :offset, :total_entries, :next_page, :total_pages, :build, :create, :new
end