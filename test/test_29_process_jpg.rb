# -*- coding: utf-8 -*-
##########################################################################
# test_29_process_jpg.rb
#
# all test is commented out because Workbook#process_jpg was set to private
# method. Before that, all test passed.
#
#
#
#
# Tests for the JPEG width and height processing.
#
# reverse('©'), September 2005, John McNamara, jmcnamara@cpan.org
#
# original written in Perl by John McNamara
# converted to Ruby by Hideo Nakamura, cxn03651@msj.biglobe.ne.jp
#
#########################################################################
require 'helper'
require 'stringio'

class TC_29_process_jpg < Test::Unit::TestCase

  def setup
    @test_file  = StringIO.new
    @workbook   = WriteExcel.new(@test_file)
    @type       = 5   # Excel Blip type (MSOBLIPTYPE).
  end

  def teardown
    @workbook.close
  end

  def test_valid_jpg_image_1
    testname = '3w x 5h jpeg image.'

    data = %w(
      FF D8 FF E0 00 10 4A 46 49 46 00 01 01 01 00 60
      00 60 00 00 FF DB 00 43 00 06 04 05 06 05 04 06
      06 05 06 07 07 06 08 0A 10 0A 0A 09 09 0A 14 0E
      0F 0C 10 17 14 18 18 17 14 16 16 1A 1D 25 1F 1A
      1B 23 1C 16 16 20 2C 20 23 26 27 29 2A 29 19 1F
      2D 30 2D 28 30 25 28 29 28 FF DB 00 43 01 07 07
      07 0A 08 0A 13 0A 0A 13 28 1A 16 1A 28 28 28 28
      28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
      28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
      28 28 28 28 28 28 28 28 28 28 28 28 28 28 FF C0
      00 11 08 00 05 00 03 03 01 22 00 02 11 01 03 11
      01 FF C4 00 15 00 01 01 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 07 FF C4 00 14 10 01 00 00
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 FF C4
      00 15 01 01 01 00 00 00 00 00 00 00 00 00 00 00
      00 00 00 06 08 FF C4 00 14 11 01 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 00 FF DA 00 0C 03
      01 00 02 11 03 11 00 3F 00 9D 00 1C A4 5F FF D9
    )
    image = [data.join('')].pack('H*')

    expected = [@type, 3, 5]
    result   = @workbook.__send__("process_jpg", image, 'test.jpg')
    assert_equal(expected, result, " \t" + testname)
  end

  def test_valid_jpg_image_2
    testname = '5w x 3h jpeg image.'

    data = %w(
      FF D8 FF E0 00 10 4A 46 49 46 00 01 01 01 00 60
      00 60 00 00 FF DB 00 43 00 06 04 05 06 05 04 06
      06 05 06 07 07 06 08 0A 10 0A 0A 09 09 0A 14 0E
      0F 0C 10 17 14 18 18 17 14 16 16 1A 1D 25 1F 1A
      1B 23 1C 16 16 20 2C 20 23 26 27 29 2A 29 19 1F
      2D 30 2D 28 30 25 28 29 28 FF DB 00 43 01 07 07
      07 0A 08 0A 13 0A 0A 13 28 1A 16 1A 28 28 28 28
      28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
      28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
      28 28 28 28 28 28 28 28 28 28 28 28 28 28 FF C0
      00 11 08 00 03 00 05 03 01 22 00 02 11 01 03 11
      01 FF C4 00 15 00 01 01 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 07 FF C4 00 14 10 01 00 00
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 FF C4
      00 15 01 01 01 00 00 00 00 00 00 00 00 00 00 00
      00 00 00 06 08 FF C4 00 14 11 01 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 00 FF DA 00 0C 03
      01 00 02 11 03 11 00 3F 00 9D 00 1C A4 5F FF D9
    )
    image = [data.join('')].pack('H*')

    expected = [@type, 5, 3]
    result   = @workbook.__send__("process_jpg", image, 'test.jpg')
    assert_equal(expected, result, " \t" + testname)
  end

  def test_valid_jpg_image_3_ffco_marker_missing
    testname = 'FFCO marker missing in image.'

    data = %w(
      FF D8 FF E0 00 10 4A 46 49 46 00 01 01 01 00 60
      00 60 00 00 FF DB 00 43 00 06 04 05 06 05 04 06
      06 05 06 07 07 06 08 0A 10 0A 0A 09 09 0A 14 0E
      0F 0C 10 17 14 18 18 17 14 16 16 1A 1D 25 1F 1A
      1B 23 1C 16 16 20 2C 20 23 26 27 29 2A 29 19 1F
      2D 30 2D 28 30 25 28 29 28 FF DB 00 43 01 07 07
      07 0A 08 0A 13 0A 0A 13 28 1A 16 1A 28 28 28 28
      28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
      28 28 28 28 28 28 28 28 28 28 28 28 28 28 28 28
      28 28 28 28 28 28 28 28 28 28 28 28 28 28 FF C1
      00 11 08 00 03 00 05 03 01 22 00 02 11 01 03 11
      01 FF C4 00 15 00 01 01 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 07 FF C4 00 14 10 01 00 00
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 FF C4
      00 15 01 01 01 00 00 00 00 00 00 00 00 00 00 00
      00 00 00 06 08 FF C4 00 14 11 01 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 00 FF DA 00 0C 03
      01 00 02 11 03 11 00 3F 00 9D 00 1C A4 5F FF D9
    )
    image = [data.join('')].pack('H*')

    assert_raise(RuntimeError, " \t" + testname) {
      @workbook.__send__("process_jpg", image, 'test.jpg')
    }
  end

  def test_invalid_jpeg_image
    testname = 'empty image'
    image    = ''

    assert_raise(RuntimeError, " \t" + testname) {
      @workbook.__send__("process_jpg", image, 'test.jpg')
    }
  end

  ###############################################################################
  #
  # Test 5. Progressive DCT-based JPEG image.
  #
  def test_progressive_dct_based_jpeg_image
    testname = '35w x 35h progressive jpeg image.'
    data = %w(
      FF D8 FF E0 00 10 4A 46 49 46 00 01 02 01 00 96
      00 96 00 00 FF E1 04 E7 45 78 69 66 00 00 4D 4D
      00 2A 00 00 00 08 00 07 01 12 00 03 00 00 00 01
      00 01 00 00 01 1A 00 05 00 00 00 01 00 00 00 62
      01 1B 00 05 00 00 00 01 00 00 00 6A 01 28 00 03
      00 00 00 01 00 02 00 00 01 31 00 02 00 00 00 14
      00 00 00 72 01 32 00 02 00 00 00 14 00 00 00 86
      87 69 00 04 00 00 00 01 00 00 00 9C 00 00 00 C8
      00 00 00 96 00 00 00 01 00 00 00 96 00 00 00 01
      41 64 6F 62 65 20 50 68 6F 74 6F 73 68 6F 70 20
      37 2E 30 00 32 30 30 38 3A 30 39 3A 30 39 20 32
      32 3A 32 33 3A 31 32 00 00 00 00 03 A0 01 00 03
      00 00 00 01 FF FF 00 00 A0 02 00 04 00 00 00 01
      00 00 00 23 A0 03 00 04 00 00 00 01 00 00 00 23
      00 00 00 00 00 00 00 06 01 03 00 03 00 00 00 01
      00 06 00 00 01 1A 00 05 00 00 00 01 00 00 01 16
      01 1B 00 05 00 00 00 01 00 00 01 1E 01 28 00 03
      00 00 00 01 00 02 00 00 02 01 00 04 00 00 00 01
      00 00 01 26 02 02 00 04 00 00 00 01 00 00 03 B9
      00 00 00 00 00 00 00 48 00 00 00 01 00 00 00 48
      00 00 00 01 FF D8 FF E0 00 10 4A 46 49 46 00 01
      02 01 00 48 00 48 00 00 FF ED 00 0C 41 64 6F 62
      65 5F 43 4D 00 02 FF EE 00 0E 41 64 6F 62 65 00
      64 80 00 00 00 01 FF DB 00 84 00 0C 08 08 08 09
      08 0C 09 09 0C 11 0B 0A 0B 11 15 0F 0C 0C 0F 15
      18 13 13 15 13 13 18 11 0C 0C 0C 0C 0C 0C 11 0C
      0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C
      0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 01 0D 0B 0B 0D
      0E 0D 10 0E 0E 10 14 0E 0E 0E 14 14 0E 0E 0E 0E
      14 11 0C 0C 0C 0C 0C 11 11 0C 0C 0C 0C 0C 0C 11
      0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C
      0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C FF C0 00 11
      08 00 23 00 23 03 01 22 00 02 11 01 03 11 01 FF
      DD 00 04 00 03 FF C4 01 3F 00 00 01 05 01 01 01
      01 01 01 00 00 00 00 00 00 00 03 00 01 02 04 05
      06 07 08 09 0A 0B 01 00 01 05 01 01 01 01 01 01
      00 00 00 00 00 00 00 01 00 02 03 04 05 06 07 08
      09 0A 0B 10 00 01 04 01 03 02 04 02 05 07 06 08
      05 03 0C 33 01 00 02 11 03 04 21 12 31 05 41 51
      61 13 22 71 81 32 06 14 91 A1 B1 42 23 24 15 52
      C1 62 33 34 72 82 D1 43 07 25 92 53 F0 E1 F1 63
      73 35 16 A2 B2 83 26 44 93 54 64 45 C2 A3 74 36
      17 D2 55 E2 65 F2 B3 84 C3 D3 75 E3 F3 46 27 94
      A4 85 B4 95 C4 D4 E4 F4 A5 B5 C5 D5 E5 F5 56 66
      76 86 96 A6 B6 C6 D6 E6 F6 37 47 57 67 77 87 97
      A7 B7 C7 D7 E7 F7 11 00 02 02 01 02 04 04 03 04
      05 06 07 07 06 05 35 01 00 02 11 03 21 31 12 04
      41 51 61 71 22 13 05 32 81 91 14 A1 B1 42 23 C1
      52 D1 F0 33 24 62 E1 72 82 92 43 53 15 63 73 34
      F1 25 06 16 A2 B2 83 07 26 35 C2 D2 44 93 54 A3
      17 64 45 55 36 74 65 E2 F2 B3 84 C3 D3 75 E3 F3
      46 94 A4 85 B4 95 C4 D4 E4 F4 A5 B5 C5 D5 E5 F5
      56 66 76 86 96 A6 B6 C6 D6 E6 F6 27 37 47 57 67
      77 87 97 A7 B7 C7 FF DA 00 0C 03 01 00 02 11 03
      11 00 3F 00 F5 54 0B 33 71 AB 79 AC BF 75 83 53
      5B 01 7B 84 F1 B9 95 EE 73 54 F2 1C E6 D1 63 9B
      F4 9A C7 16 FC 40 5C F7 49 B7 1A FA 19 51 BF 23
      1B 2C B4 3A EC 7B 2D 65 76 6E 23 DC FD 06 FB 58
      FF 00 A4 CB 92 53 1E B9 F5 9B 3E 96 DB 8D 83 D3
      B2 85 A7 DB 56 53 D8 1B 5C E9 EE 0F 7E E6 37 FE
      B8 AF FD 5B FD AA 71 9E EE A2 CB 6A 26 36 D7 7B
      C5 8F 07 5D EE DE 27 F4 7F 43 E9 21 E5 D5 85 8D
      59 39 B9 04 56 EE 45 D9 6F F7 79 7A 6D 1E FF 00
      EA AB 9D 0A C3 67 4D AC 9A AC C7 01 CF 0C A6 D2
      4B DA D0 E7 7A 61 FE A4 BF E8 7E FA 4A 74 12 49
      24 94 FF 00 FF D0 F5 2B DA 5D 4D 8D 1C B9 A4 7D
      E1 66 F4 FB BA 7F 50 C3 C7 17 D4 CF 59 B5 33 F4
      57 06 97 00 47 2D 9F CC 74 7D 26 2D 55 CC 7D 61
      CD 7F 40 38 66 BA 99 76 16 4D CE AD EC B8 4B 69
      2E 06 C6 7A 76 0F 73 37 D9 EC D8 EF EC 24 A7 61
      95 74 7C 70 6F 6B 28 AF 61 FE 72 1B 20 8F DD 77
      D2 44 E9 97 8C 8C 63 7B 5A E6 36 CB 2C 21 AE D1
      D0 1E EA F5 1F D8 58 1F 57 FA 95 DD 6B 23 25 B5
      D5 5E 23 31 F6 13 63 1A 1E F9 70 73 76 56 F7 7B
      6A FE 6F 7F D0 FC F5 D3 63 D1 56 3D 2C A6 A6 ED
      AD 82 1A 12 52 44 92 49 25 3F FF D1 F5 55 47 AD
      C7 EC AC AD DE 84 7A 6E 9F B5 4F A3 11 FE 1B 67
      BF 67 F5 17 CC 69 24 A7 E9 6F AB BB 7F 66 55 B7
      EC BB 60 47 D8 B7 7A 5C 7F C2 7E 93 FC F5 A8 BE
      55 49 25 3F 55 24 BE 55 49 25 3F FF D9 FF ED 09
      94 50 68 6F 74 6F 73 68 6F 70 20 33 2E 30 00 38
      42 49 4D 04 25 00 00 00 00 00 10 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 00 38 42 49 4D 03
      ED 00 00 00 00 00 10 00 96 00 00 00 01 00 01 00
      96 00 00 00 01 00 01 38 42 49 4D 04 26 00 00 00
      00 00 0E 00 00 00 00 00 00 00 00 00 00 3F 80 00
      00 38 42 49 4D 04 0D 00 00 00 00 00 04 00 00 00
      1E 38 42 49 4D 04 19 00 00 00 00 00 04 00 00 00
      1E 38 42 49 4D 03 F3 00 00 00 00 00 09 00 00 00
      00 00 00 00 00 01 00 38 42 49 4D 04 0A 00 00 00
      00 00 01 00 00 38 42 49 4D 27 10 00 00 00 00 00
      0A 00 01 00 00 00 00 00 00 00 01 38 42 49 4D 03
      F5 00 00 00 00 00 48 00 2F 66 66 00 01 00 6C 66
      66 00 06 00 00 00 00 00 01 00 2F 66 66 00 01 00
      A1 99 9A 00 06 00 00 00 00 00 01 00 32 00 00 00
      01 00 5A 00 00 00 06 00 00 00 00 00 01 00 35 00
      00 00 01 00 2D 00 00 00 06 00 00 00 00 00 01 38
      42 49 4D 03 F8 00 00 00 00 00 70 00 00 FF FF FF
      FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
      FF FF FF 03 E8 00 00 00 00 FF FF FF FF FF FF FF
      FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF 03
      E8 00 00 00 00 FF FF FF FF FF FF FF FF FF FF FF
      FF FF FF FF FF FF FF FF FF FF FF 03 E8 00 00 00
      00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF
      FF FF FF FF FF FF FF 03 E8 00 00 38 42 49 4D 04
      08 00 00 00 00 00 10 00 00 00 01 00 00 02 40 00
      00 02 40 00 00 00 00 38 42 49 4D 04 1E 00 00 00
      00 00 04 00 00 00 00 38 42 49 4D 04 1A 00 00 00
      00 03 59 00 00 00 06 00 00 00 00 00 00 00 00 00
      00 00 23 00 00 00 23 00 00 00 12 00 54 00 43 00
      50 00 5F 00 43 00 69 00 72 00 63 00 6C 00 65 00
      5F 00 42 00 61 00 6C 00 6C 00 61 00 73 00 74 00
      00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00
      00 00 23 00 00 00 23 00 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 01 00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00 00 00 00 10 00 00 00 01
      00 00 00 00 00 00 6E 75 6C 6C 00 00 00 02 00 00
      00 06 62 6F 75 6E 64 73 4F 62 6A 63 00 00 00 01
      00 00 00 00 00 00 52 63 74 31 00 00 00 04 00 00
      00 00 54 6F 70 20 6C 6F 6E 67 00 00 00 00 00 00
      00 00 4C 65 66 74 6C 6F 6E 67 00 00 00 00 00 00
      00 00 42 74 6F 6D 6C 6F 6E 67 00 00 00 23 00 00
      00 00 52 67 68 74 6C 6F 6E 67 00 00 00 23 00 00
      00 06 73 6C 69 63 65 73 56 6C 4C 73 00 00 00 01
      4F 62 6A 63 00 00 00 01 00 00 00 00 00 05 73 6C
      69 63 65 00 00 00 12 00 00 00 07 73 6C 69 63 65
      49 44 6C 6F 6E 67 00 00 00 00 00 00 00 07 67 72
      6F 75 70 49 44 6C 6F 6E 67 00 00 00 00 00 00 00
      06 6F 72 69 67 69 6E 65 6E 75 6D 00 00 00 0C 45
      53 6C 69 63 65 4F 72 69 67 69 6E 00 00 00 0D 61
      75 74 6F 47 65 6E 65 72 61 74 65 64 00 00 00 00
      54 79 70 65 65 6E 75 6D 00 00 00 0A 45 53 6C 69
      63 65 54 79 70 65 00 00 00 00 49 6D 67 20 00 00
      00 06 62 6F 75 6E 64 73 4F 62 6A 63 00 00 00 01
      00 00 00 00 00 00 52 63 74 31 00 00 00 04 00 00
      00 00 54 6F 70 20 6C 6F 6E 67 00 00 00 00 00 00
      00 00 4C 65 66 74 6C 6F 6E 67 00 00 00 00 00 00
      00 00 42 74 6F 6D 6C 6F 6E 67 00 00 00 23 00 00
      00 00 52 67 68 74 6C 6F 6E 67 00 00 00 23 00 00
      00 03 75 72 6C 54 45 58 54 00 00 00 01 00 00 00
      00 00 00 6E 75 6C 6C 54 45 58 54 00 00 00 01 00
      00 00 00 00 00 4D 73 67 65 54 45 58 54 00 00 00
      01 00 00 00 00 00 06 61 6C 74 54 61 67 54 45 58
      54 00 00 00 01 00 00 00 00 00 0E 63 65 6C 6C 54
      65 78 74 49 73 48 54 4D 4C 62 6F 6F 6C 01 00 00
      00 08 63 65 6C 6C 54 65 78 74 54 45 58 54 00 00
      00 01 00 00 00 00 00 09 68 6F 72 7A 41 6C 69 67
      6E 65 6E 75 6D 00 00 00 0F 45 53 6C 69 63 65 48
      6F 72 7A 41 6C 69 67 6E 00 00 00 07 64 65 66 61
      75 6C 74 00 00 00 09 76 65 72 74 41 6C 69 67 6E
      65 6E 75 6D 00 00 00 0F 45 53 6C 69 63 65 56 65
      72 74 41 6C 69 67 6E 00 00 00 07 64 65 66 61 75
      6C 74 00 00 00 0B 62 67 43 6F 6C 6F 72 54 79 70
      65 65 6E 75 6D 00 00 00 11 45 53 6C 69 63 65 42
      47 43 6F 6C 6F 72 54 79 70 65 00 00 00 00 4E 6F
      6E 65 00 00 00 09 74 6F 70 4F 75 74 73 65 74 6C
      6F 6E 67 00 00 00 00 00 00 00 0A 6C 65 66 74 4F
      75 74 73 65 74 6C 6F 6E 67 00 00 00 00 00 00 00
      0C 62 6F 74 74 6F 6D 4F 75 74 73 65 74 6C 6F 6E
      67 00 00 00 00 00 00 00 0B 72 69 67 68 74 4F 75
      74 73 65 74 6C 6F 6E 67 00 00 00 00 00 38 42 49
      4D 04 11 00 00 00 00 00 01 01 00 38 42 49 4D 04
      14 00 00 00 00 00 04 00 00 00 01 38 42 49 4D 04
      0C 00 00 00 00 03 D5 00 00 00 01 00 00 00 23 00
      00 00 23 00 00 00 6C 00 00 0E C4 00 00 03 B9 00
      18 00 01 FF D8 FF E0 00 10 4A 46 49 46 00 01 02
      01 00 48 00 48 00 00 FF ED 00 0C 41 64 6F 62 65
      5F 43 4D 00 02 FF EE 00 0E 41 64 6F 62 65 00 64
      80 00 00 00 01 FF DB 00 84 00 0C 08 08 08 09 08
      0C 09 09 0C 11 0B 0A 0B 11 15 0F 0C 0C 0F 15 18
      13 13 15 13 13 18 11 0C 0C 0C 0C 0C 0C 11 0C 0C
      0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C
      0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 01 0D 0B 0B 0D 0E
      0D 10 0E 0E 10 14 0E 0E 0E 14 14 0E 0E 0E 0E 14
      11 0C 0C 0C 0C 0C 11 11 0C 0C 0C 0C 0C 0C 11 0C
      0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C
      0C 0C 0C 0C 0C 0C 0C 0C 0C 0C 0C FF C0 00 11 08
      00 23 00 23 03 01 22 00 02 11 01 03 11 01 FF DD
      00 04 00 03 FF C4 01 3F 00 00 01 05 01 01 01 01
      01 01 00 00 00 00 00 00 00 03 00 01 02 04 05 06
      07 08 09 0A 0B 01 00 01 05 01 01 01 01 01 01 00
      00 00 00 00 00 00 01 00 02 03 04 05 06 07 08 09
      0A 0B 10 00 01 04 01 03 02 04 02 05 07 06 08 05
      03 0C 33 01 00 02 11 03 04 21 12 31 05 41 51 61
      13 22 71 81 32 06 14 91 A1 B1 42 23 24 15 52 C1
      62 33 34 72 82 D1 43 07 25 92 53 F0 E1 F1 63 73
      35 16 A2 B2 83 26 44 93 54 64 45 C2 A3 74 36 17
      D2 55 E2 65 F2 B3 84 C3 D3 75 E3 F3 46 27 94 A4
      85 B4 95 C4 D4 E4 F4 A5 B5 C5 D5 E5 F5 56 66 76
      86 96 A6 B6 C6 D6 E6 F6 37 47 57 67 77 87 97 A7
      B7 C7 D7 E7 F7 11 00 02 02 01 02 04 04 03 04 05
      06 07 07 06 05 35 01 00 02 11 03 21 31 12 04 41
      51 61 71 22 13 05 32 81 91 14 A1 B1 42 23 C1 52
      D1 F0 33 24 62 E1 72 82 92 43 53 15 63 73 34 F1
      25 06 16 A2 B2 83 07 26 35 C2 D2 44 93 54 A3 17
      64 45 55 36 74 65 E2 F2 B3 84 C3 D3 75 E3 F3 46
      94 A4 85 B4 95 C4 D4 E4 F4 A5 B5 C5 D5 E5 F5 56
      66 76 86 96 A6 B6 C6 D6 E6 F6 27 37 47 57 67 77
      87 97 A7 B7 C7 FF DA 00 0C 03 01 00 02 11 03 11
      00 3F 00 F5 54 0B 33 71 AB 79 AC BF 75 83 53 5B
      01 7B 84 F1 B9 95 EE 73 54 F2 1C E6 D1 63 9B F4
      9A C7 16 FC 40 5C F7 49 B7 1A FA 19 51 BF 23 1B
      2C B4 3A EC 7B 2D 65 76 6E 23 DC FD 06 FB 58 FF
      00 A4 CB 92 53 1E B9 F5 9B 3E 96 DB 8D 83 D3 B2
      85 A7 DB 56 53 D8 1B 5C E9 EE 0F 7E E6 37 FE B8
      AF FD 5B FD AA 71 9E EE A2 CB 6A 26 36 D7 7B C5
      8F 07 5D EE DE 27 F4 7F 43 E9 21 E5 D5 85 8D 59
      39 B9 04 56 EE 45 D9 6F F7 79 7A 6D 1E FF 00 EA
      AB 9D 0A C3 67 4D AC 9A AC C7 01 CF 0C A6 D2 4B
      DA D0 E7 7A 61 FE A4 BF E8 7E FA 4A 74 12 49 24
      94 FF 00 FF D0 F5 2B DA 5D 4D 8D 1C B9 A4 7D E1
      66 F4 FB BA 7F 50 C3 C7 17 D4 CF 59 B5 33 F4 57
      06 97 00 47 2D 9F CC 74 7D 26 2D 55 CC 7D 61 CD
      7F 40 38 66 BA 99 76 16 4D CE AD EC B8 4B 69 2E
      06 C6 7A 76 0F 73 37 D9 EC D8 EF EC 24 A7 61 95
      74 7C 70 6F 6B 28 AF 61 FE 72 1B 20 8F DD 77 D2
      44 E9 97 8C 8C 63 7B 5A E6 36 CB 2C 21 AE D1 D0
      1E EA F5 1F D8 58 1F 57 FA 95 DD 6B 23 25 B5 D5
      5E 23 31 F6 13 63 1A 1E F9 70 73 76 56 F7 7B 6A
      FE 6F 7F D0 FC F5 D3 63 D1 56 3D 2C A6 A6 ED AD
      82 1A 12 52 44 92 49 25 3F FF D1 F5 55 47 AD C7
      EC AC AD DE 84 7A 6E 9F B5 4F A3 11 FE 1B 67 BF
      67 F5 17 CC 69 24 A7 E9 6F AB BB 7F 66 55 B7 EC
      BB 60 47 D8 B7 7A 5C 7F C2 7E 93 FC F5 A8 BE 55
      49 25 3F 55 24 BE 55 49 25 3F FF D9 00 38 42 49
      4D 04 21 00 00 00 00 00 55 00 00 00 01 01 00 00
      00 0F 00 41 00 64 00 6F 00 62 00 65 00 20 00 50
      00 68 00 6F 00 74 00 6F 00 73 00 68 00 6F 00 70
      00 00 00 13 00 41 00 64 00 6F 00 62 00 65 00 20
      00 50 00 68 00 6F 00 74 00 6F 00 73 00 68 00 6F
      00 70 00 20 00 37 00 2E 00 30 00 00 00 01 00 38
      42 49 4D 04 06 00 00 00 00 00 07 00 08 01 01 00
      01 01 00 FF E1 12 48 68 74 74 70 3A 2F 2F 6E 73
      2E 61 64 6F 62 65 2E 63 6F 6D 2F 78 61 70 2F 31
      2E 30 2F 00 3C 3F 78 70 61 63 6B 65 74 20 62 65
      67 69 6E 3D 27 EF BB BF 27 20 69 64 3D 27 57 35
      4D 30 4D 70 43 65 68 69 48 7A 72 65 53 7A 4E 54
      63 7A 6B 63 39 64 27 3F 3E 0A 3C 3F 61 64 6F 62
      65 2D 78 61 70 2D 66 69 6C 74 65 72 73 20 65 73
      63 3D 22 43 52 22 3F 3E 0A 3C 78 3A 78 61 70 6D
      65 74 61 20 78 6D 6C 6E 73 3A 78 3D 27 61 64 6F
      62 65 3A 6E 73 3A 6D 65 74 61 2F 27 20 78 3A 78
      61 70 74 6B 3D 27 58 4D 50 20 74 6F 6F 6C 6B 69
      74 20 32 2E 38 2E 32 2D 33 33 2C 20 66 72 61 6D
      65 77 6F 72 6B 20 31 2E 35 27 3E 0A 3C 72 64 66
      3A 52 44 46 20 78 6D 6C 6E 73 3A 72 64 66 3D 27
      68 74 74 70 3A 2F 2F 77 77 77 2E 77 33 2E 6F 72
      67 2F 31 39 39 39 2F 30 32 2F 32 32 2D 72 64 66
      2D 73 79 6E 74 61 78 2D 6E 73 23 27 20 78 6D 6C
      6E 73 3A 69 58 3D 27 68 74 74 70 3A 2F 2F 6E 73
      2E 61 64 6F 62 65 2E 63 6F 6D 2F 69 58 2F 31 2E
      30 2F 27 3E 0A 0A 20 3C 72 64 66 3A 44 65 73 63
      72 69 70 74 69 6F 6E 20 61 62 6F 75 74 3D 27 75
      75 69 64 3A 34 37 38 34 61 35 39 66 2D 37 65 64
      66 2D 31 31 64 64 2D 39 61 37 39 2D 61 31 62 66
      63 38 33 61 61 63 63 36 27 0A 20 20 78 6D 6C 6E
      73 3A 78 61 70 4D 4D 3D 27 68 74 74 70 3A 2F 2F
      6E 73 2E 61 64 6F 62 65 2E 63 6F 6D 2F 78 61 70
      2F 31 2E 30 2F 6D 6D 2F 27 3E 0A 20 20 3C 78 61
      70 4D 4D 3A 44 6F 63 75 6D 65 6E 74 49 44 3E 61
      64 6F 62 65 3A 64 6F 63 69 64 3A 70 68 6F 74 6F
      73 68 6F 70 3A 34 37 38 34 61 35 39 64 2D 37 65
      64 66 2D 31 31 64 64 2D 39 61 37 39 2D 61 31 62
      66 63 38 33 61 61 63 63 36 3C 2F 78 61 70 4D 4D
      3A 44 6F 63 75 6D 65 6E 74 49 44 3E 0A 20 3C 2F
      72 64 66 3A 44 65 73 63 72 69 70 74 69 6F 6E 3E
      0A 0A 3C 2F 72 64 66 3A 52 44 46 3E 0A 3C 2F 78
      3A 78 61 70 6D 65 74 61 3E 0A 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 0A 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 0A 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 0A 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 0A 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 0A 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 0A 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 0A 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 0A 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 0A 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 0A 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      0A 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 0A 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 0A 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 0A
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 0A 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 0A 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 0A 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 0A 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 0A 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 0A 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 0A 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 0A 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 0A 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 0A 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 0A 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 0A 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      0A 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 0A 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 0A 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 0A
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 0A 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 0A 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 0A 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 0A 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 0A 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 0A 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 0A 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 0A 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 0A 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 0A 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
      20 20 20 20 20 20 20 20 20 0A 3C 3F 78 70 61 63
      6B 65 74 20 65 6E 64 3D 27 77 27 3F 3E FF EE 00
      21 41 64 6F 62 65 00 64 40 00 00 00 01 03 00 10
      03 02 03 06 00 00 00 00 00 00 00 00 00 00 00 00
      FF DB 00 84 00 01 01 01 01 01 01 01 01 01 01 01
      01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
      01 01 01 01 01 01 01 01 01 01 01 01 01 01 01 01
      02 02 02 02 02 02 02 02 02 02 02 03 03 03 03 03
      03 03 03 03 03 01 01 01 01 01 01 01 01 01 01 01
      02 02 01 02 02 03 03 03 03 03 03 03 03 03 03 03
      03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
      03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03
      03 03 03 03 03 03 FF C2 00 11 08 00 23 00 23 03
    )
    image = [data.join('')].pack('H*')
    expected = [@type, 35, 35]
    results  = @workbook.__send__("process_jpg", image, 'test.jpg')
    assert_equal(expected, results)
  end
end
