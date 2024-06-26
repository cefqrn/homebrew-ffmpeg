class Ffmpeg < Formula
  desc "Play, record, convert, and stream audio and video"
  homepage "https://ffmpeg.org/"
  url "https://ffmpeg.org/releases/ffmpeg-7.0.tar.xz"
  sha256 "4426a94dd2c814945456600c8adfc402bee65ec14a70e8c531ec9a2cd651da7b"
  license "GPL-2.0-or-later"
  head "https://git.ffmpeg.org/ffmpeg.git"

  depends_on "nasm" => :build
  depends_on "pkg-config" => :build

  depends_on "lame" # libmp3lame
  depends_on "librsvg"
  depends_on "libvorbis"
  depends_on "libvpx"
  depends_on "openjpeg" # libopenjpeg
  depends_on "opus" # libopus
  depends_on "sdl2"
  depends_on "webp" # libwebp
  depends_on "x264" # libx264
  depends_on "x265" # libx265

  def install
    args = %w[
      --enable-gpl
      --enable-shared
      --enable-libmp3lame
      --enable-libopenjpeg
      --enable-libopus
      --enable-librsvg
      --enable-libvorbis
      --enable-libvpx
      --enable-libwebp
      --enable-libx264
      --enable-libx265
    ]

    system "./configure", "--prefix=#{prefix}", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"ffmpeg", "-t", "5", "-f", "lavfi", "-i", "testsrc", "-pix_fmt", "yuv420p", testpath/"out.mp4"
    assert_predicate testpath/"out.mp4", :exist?
  end
end
