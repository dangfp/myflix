shared_examples "require_signed_in" do
  it "redirects to the sign in page" do
    action
    expect(response).to redirect_to(sign_in_path)
  end
end