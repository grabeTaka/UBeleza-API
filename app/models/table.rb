class Table < ApplicationRecord
  has_one_attached :qrcode

  belongs_to :establishment

  before_save :generate_token
  after_save :generate_qrcode

  private
  def generate_token
    self.token = SecureRandom.uuid if self.token.nil?
  end

  def generate_qrcode
    unless self.qrcode.attached?
      qrcode = RQRCode::QRCode.new( self.token )
      image = qrcode.as_png(size: 600)

      file = Tempfile.new("#{self.token}.png")
      file.binmode
      file.write(image.to_blob)
      file.flush
      file.rewind

      self.qrcode.attach(io: file, filename: "#{self.establishment.name} - #{self.name}.png", content_type: "image/png")
    end
  end
end
