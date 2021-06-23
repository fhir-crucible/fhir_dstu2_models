require_relative '../test_helper'

class EachElementTest < Test::Unit::TestCase
  def setup
    @patient = FHIR::DSTU2::Patient.new(
      id: 'ID',
      name: [
        {
          use: 'maiden',
          text: 'Jane Jill Roe',
          family: ['Roe'],
          given: ['Jane', 'Jill']
        },
        {
          use: 'official',
          text: 'Jane Roe Doe',
          family: ['Doe'],
          given: ['Jane', 'Roe']
        }
      ]
    )
  end

  def test_all_elements_reached
    expected_paths = [
      'id',
      'name[0]',
      'name[0].use',
      'name[0].text',
      'name[0].family[0]',
      'name[0].given[0]',
      'name[0].given[1]',
      'name[1]',
      'name[1].use',
      'name[1].text',
      'name[1].family[0]',
      'name[1].given[0]',
      'name[1].given[1]'
    ]

    paths_reached = []
    @patient.each_element { |_, _, path| paths_reached << path }

    assert_equal expected_paths, paths_reached
  end

  def test_metadata_received
    @patient.each_element { |_, metadata, _| assert metadata.is_a? Hash }
  end

  def test_values_received
    expected_values = [
      'ID',
      'maiden',
      'Jane Jill Roe',
      'Roe',
      'Jane',
      'Jill',
      'official',
      'Jane Roe Doe',
      'Doe'
    ]

    values_received = []
    @patient.each_element { |value, _, _| values_received << value }

    expected_values.each { |value| assert values_received.include?(value), "#each_element did not see: #{value}" }

    human_names = values_received.select { |value| value.is_a?(FHIR::DSTU2::HumanName) }
    assert_equal 2, human_names.length, '#each_element did not see two HumanNames'
  end

  def test_return_value
    assert_equal @patient, @patient.each_element { |_, _, path| path }
  end
end
