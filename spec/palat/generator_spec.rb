require 'spec_helper'

describe Palat::Generator do
  expected_output = <<-RESULT
f7f7f7: $backgroundColor:#f7f7f7;$baseColor:#3d3d3d;$errorColor:#ff6a6a;$errorBubbleBackground:#ff6a6a;$errorBubbleColor:#ffffff;$inputBackground:#fafafa;$inputBackgroundFocus:#fdfdfd;$inputColor:#3d3d3d;$dropdownBackground:#f7f7f7;$dropdownColor:#3d3d3d;
c4c4c4: $backgroundColor:#c4c4c4;$baseColor:#353535;$errorColor:#ef0000;$errorBubbleBackground:#ef0000;$errorBubbleColor:#ffffff;$inputBackground:#dcdcdc;$inputBackgroundFocus:#ededed;$inputColor:#353535;$dropdownBackground:#c4c4c4;$dropdownColor:#353535;
949494: $backgroundColor:#949494;$baseColor:#000000;$errorColor:#a30000;$errorBubbleBackground:#a30000;$errorBubbleColor:#ffffff;$inputBackground:#bfbfbf;$inputBackgroundFocus:#dfdfdf;$inputColor:#000000;$dropdownBackground:#949494;$dropdownColor:#000000;
6e6e6e: $backgroundColor:#6e6e6e;$baseColor:#ffffff;$errorColor:#6c0000;$errorBubbleBackground:#6c0000;$errorBubbleColor:#ffffff;$inputBackground:#585858;$inputBackgroundFocus:#2c2c2c;$inputColor:#ffffff;$dropdownBackground:#ffffff;$dropdownColor:#6e6e6e;
444444: $backgroundColor:#444444;$baseColor:#dddddd;$errorColor:#ff1818;$errorBubbleBackground:#ff1818;$errorBubbleColor:#ffffff;$inputBackground:#363636;$inputBackgroundFocus:#1b1b1b;$inputColor:#dddddd;$dropdownBackground:#dddddd;$dropdownColor:#444444;
47141D: $backgroundColor:#47141d;$baseColor:#f3f1f1;$errorColor:#b63c33;$errorBubbleBackground:#b63c33;$errorBubbleColor:#ffffff;$inputBackground:#391017;$inputBackgroundFocus:#1c080c;$inputColor:#f3f1f1;$dropdownBackground:#f3f1f1;$dropdownColor:#47141d;
333022: $backgroundColor:#333022;$baseColor:#fefefe;$errorColor:#ae514a;$errorBubbleBackground:#ae514a;$errorBubbleColor:#ffffff;$inputBackground:#29261b;$inputBackgroundFocus:#14130e;$inputColor:#fefefe;$dropdownBackground:#fefefe;$dropdownColor:#333022;
073329: $backgroundColor:#073329;$baseColor:#f2f4f4;$errorColor:#d4201d;$errorBubbleBackground:#d4201d;$errorBubbleColor:#ffffff;$inputBackground:#062921;$inputBackgroundFocus:#031410;$inputColor:#f2f4f4;$dropdownBackground:#f2f4f4;$dropdownColor:#073329;
072333: $backgroundColor:#072333;$baseColor:#e4e7e9;$errorColor:#b92c1a;$errorBubbleBackground:#b92c1a;$errorBubbleColor:#ffffff;$inputBackground:#061c29;$inputBackgroundFocus:#030e14;$inputColor:#e4e7e9;$dropdownBackground:#e4e7e9;$dropdownColor:#072333;
2E0D33: $backgroundColor:#2e0d33;$baseColor:#e8e5e9;$errorColor:#a5382a;$errorBubbleBackground:#a5382a;$errorBubbleColor:#ffffff;$inputBackground:#250a29;$inputBackgroundFocus:#120514;$inputColor:#e8e5e9;$dropdownBackground:#e8e5e9;$dropdownColor:#2e0d33;
D12A6D: $backgroundColor:#d12a6d;$baseColor:#ffffff;$errorColor:#edaea7;$errorBubbleBackground:#edaea7;$errorBubbleColor:#ffffff;$inputBackground:#a72257;$inputBackgroundFocus:#54112c;$inputColor:#ffffff;$dropdownBackground:#ffffff;$dropdownColor:#d12a6d;
FF7F4C: $backgroundColor:#ff7f4c;$baseColor:#2d0d00;$errorColor:#bc0600;$errorBubbleBackground:#bc0600;$errorBubbleColor:#ffffff;$inputBackground:#ffb294;$inputBackgroundFocus:#ffd9c9;$inputColor:#2d0d00;$dropdownBackground:#ff7f4c;$dropdownColor:#2d0d00;
1BC7A2: $backgroundColor:#1bc7a2;$baseColor:#062922;$errorColor:#c7211b;$errorBubbleBackground:#c7211b;$errorBubbleColor:#ffffff;$inputBackground:#76ddc7;$inputBackgroundFocus:#bbeee3;$inputColor:#062922;$dropdownBackground:#1bc7a2;$dropdownColor:#062922;
37A6E6: $backgroundColor:#37a6e6;$baseColor:#03121a;$errorColor:#ac2715;$errorBubbleBackground:#ac2715;$errorBubbleColor:#ffffff;$inputBackground:#87caf0;$inputBackgroundFocus:#c3e4f8;$inputColor:#03121a;$dropdownBackground:#37a6e6;$dropdownColor:#03121a;
AF45BF: $backgroundColor:#af45bf;$baseColor:#ffffff;$errorColor:#57251e;$errorBubbleBackground:#57251e;$errorBubbleColor:#ffffff;$inputBackground:#8c3799;$inputBackgroundFocus:#461c4c;$inputColor:#ffffff;$dropdownBackground:#ffffff;$dropdownColor:#af45bf;
FFF7F5: $backgroundColor:#fff7f5;$baseColor:#463834;$errorColor:#ff2934;$errorBubbleBackground:#ff2934;$errorBubbleColor:#ffffff;$inputBackground:#fffaf9;$inputBackgroundFocus:#fffdfc;$inputColor:#463834;$dropdownBackground:#fff7f5;$dropdownColor:#463834;
FCF9F2: $backgroundColor:#fcf9f2;$baseColor:#34322c;$errorColor:#d64c53;$errorBubbleBackground:#d64c53;$errorBubbleColor:#ffffff;$inputBackground:#fdfbf7;$inputBackgroundFocus:#fefdfb;$inputColor:#34322c;$dropdownBackground:#fcf9f2;$dropdownColor:#34322c;
F8FFF5: $backgroundColor:#f8fff5;$baseColor:#21291e;$errorColor:#ff2934;$errorBubbleBackground:#ff2934;$errorBubbleColor:#ffffff;$inputBackground:#fbfff9;$inputBackgroundFocus:#fdfffc;$inputColor:#21291e;$dropdownBackground:#f8fff5;$dropdownColor:#21291e;
F5FDFF: $backgroundColor:#f5fdff;$baseColor:#252f32;$errorColor:#ff2934;$errorBubbleBackground:#ff2934;$errorBubbleColor:#ffffff;$inputBackground:#f9feff;$inputBackgroundFocus:#fcfeff;$inputColor:#252f32;$dropdownBackground:#f5fdff;$dropdownColor:#252f32;
F7E6FF: $backgroundColor:#f7e6ff;$baseColor:#433649;$errorColor:#ff1a29;$errorBubbleBackground:#ff1a29;$errorBubbleColor:#ffffff;$inputBackground:#faf0ff;$inputBackgroundFocus:#fdf8ff;$inputColor:#433649;$dropdownBackground:#f7e6ff;$dropdownColor:#433649;
  RESULT

  it 'calculates properly' do
    calculations = test_color_array.map do |x|
      "#{x}: #{described_class.new(x).to_scss}"
    end.join("\n")

    expect(calculations.strip).to eq(expected_output.strip)
  end
end
