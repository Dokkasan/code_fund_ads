class Emails::AttachmentsComponent < ApplicationComponent
  def initialize(classes: classes, blobs: [])
    @class_names = classes
    @blobs = blobs
  end

  private

  attr_reader :class_names, :blobs

  def render?
    blobs.present?
  end
end
