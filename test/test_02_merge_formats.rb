###########################################################################
# test_02_merge_formats.rb
#
# Tests to ensure merge formats aren't used in non-merged cells and
# vice-versa. This is temporary feature to prevent users from inadvertently
# making this error.
#
# reverse('©'), April 2005, John McNamara, jmcnamara@cpan.org
#
############################################################################
base = File.basename(Dir.pwd)
if base == "test" || base =~ /spreadsheet/i
  Dir.chdir("..") if base == "test"
  $LOAD_PATH.unshift(Dir.pwd + "/lib/spreadsheet")
  Dir.chdir("test") rescue nil
end

require "test/unit"
require "biffwriter"
require "olewriter"
require "format"
require "formula"
require "worksheet"
require "workbook"
require "excel"
include Spreadsheet

class TC_merge_formats < Test::Unit::TestCase

  def setup
    @test_file           = "temp_test_file.xls"
    @workbook            = Excel.new(@test_file)
    @worksheet           = @workbook.add_worksheet
    @merged_format       = @workbook.add_format(:bold => 1)
    @non_merged_format   = @workbook.add_format(:bold => 1)

    @worksheet.set_row(    5,    nil, @merged_format)
    @worksheet.set_column('G:G', nil, @merged_format)
  end

  def teardown
    @workbook.close
  end

  def test_some
    # Test 1   Normal usage.
    assert_nothing_raised { @worksheet.write('A1',    'Test', @non_merged_format) }
    assert_nothing_raised { @worksheet.write('A3:B4', 'Test', @merged_format) }

    # Test 2   Non merge format in merged cells.
    assert_nothing_raised {
      @worksheet.merge_range('D3:E4', 'Test', @non_merged_format)
    }

    # Test 3   Merge format in column.
    assert_nothing_raised { @worksheet.write('G1', 'Test') }

    # Test 4   Merge format in row.
    assert_nothing_raised { @worksheet.write('A6', 'Test') }

    # Test 5   Merge format in column and row.
    assert_nothing_raised { @worksheet.write('G6', 'Test') }

    # Test 6   No merge format in column and row.
    assert_nothing_raised { @worksheet.write('H7', 'Test') }

    # Test 7   Normal usage again.
    assert_nothing_raised {
      @worksheet.write('A1',    'Test', @non_merged_format)
    }
    assert_nothing_raised {
      @worksheet.merge_range('A3:B4', 'Test', @merged_format)
    }
  end


end
