#encoding: utf-8
class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
    report=::CompanyReport.new
    report.company = @company
    respond_to do |f|
      f.html 
      f.pdf do 
        send_data report.to_pdf,
          :filename => "(#{Time.now.strftime("%Y%m%d")})#{@company.name}.pdf", 
          :type => "application/pdf" 
      end
    end
  end

  def update_company
    company = Company.find(params[:id])
    respond_to do |format|
      if company.update_attributes(params[:company])
        #format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content } # 204 No Content
      else
        #format.html { render action: "edit" }
        format.json { render text: company.errors.full_messages.join(","), status: :unprocessable_entity }
      end
    end
  end

  def update_business
    company = Company.find(params[:id])
    business = company.business

    updated = 
      unless company.business
        business = company.build_business(params[:business])
        business.save
      else
        business.update_attributes(params[:business])
      end

    business.recount

    respond_to do |format|
      if updated 
        #format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content } # 204 No Content
      else
        #format.html { render action: "edit" }
        format.json { render text: company.business.errors.full_messages.join(","), status: :unprocessable_entity }
      end
    end

  end

  def create
    @company = Company.create(params[:company])
    respond_to do |f|
      f.html { redirect_to @company }
    end
  end

  def search
    @companies = Company.seek(company_name: params[:key])
    respond_with(@companies)
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
  end

end
