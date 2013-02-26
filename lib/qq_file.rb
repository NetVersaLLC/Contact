#!/usr/bin/env ruby

require 'digest/sha1'
require 'mime/types'

# Usage (paperclip example)
# @asset.data = QqFile.new(params[:qqfile], request)
class QqFile < File

  def initialize(filename, request)
    @original_filename  = filename
    @request            = request
    @extension          = File.extname(@original_filename)
    @temp_file          = Image.new_tmpfile
    @temp_file         += @extension if @extension
    STDERR.puts "TMP: "+@temp_file
    super(@temp_file, "wb+")
    fetch
  end

  def self.parse(*args)
    return args.first unless args.first.is_a?(String)
    new(*args)
  end

  def fetch
    write  @request.raw_post
    self
  end

  def original_filename
    @original_filename
  end

  def content_type
    types = MIME::Types.type_for(@request.content_type)
      types.empty? ? @request.content_type : types.first.to_s
  end
end

