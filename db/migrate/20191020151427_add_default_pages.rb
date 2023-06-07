class AddDefaultPages < ActiveRecord::Migration[6.0]
  def change
    text = <<HEREDOC
    <div>

                    <p>
                        <span class="description"></span>
                    </p>
                                            <p><strong>SAAS AGREEMENT</strong></p>
<p>This SOFTWARE AS AGREEMENT ABOUT LICENSE FOR SERVICE (this "Agreement"), is between Global Supplies, which is between a physical or legal person that is a "Subscriber" or "User" of the "Software" (as defined below) and any related services provided by JPC COMMERCE GROUP LTD, frome the on side hereinafter reffered as the “Subscriber” and by company JPC COMMERCE GROUP LTD, having its principal place of business by address: Griva Digeni, 12 Flat/Office 4 , Neapoli, Limassol,&nbsp;P.C. 3106, Cyprus Nr., hereinafter referred to “Company”, which operates on the basis of the Statute, from the other side, hereinafter referred to as the "Implementar" and which has in usage the trademark Global Supplies.</p>
<p>If you pay for the Global Supplies (services) on the terms of this Agreement or take any other affirmative action indicating your acceptance of this Agreement, then you have agreed to these terms. If you are an agent or employee of the intended subscriber or user, you individually represent and warrant to Global Supplies that you are authorized to bind that party to this Agreement.</p>
<p>The date of the last change: 01.07.2019</p>
<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1. DEFINITIONS</strong></p>
<p>1.1.&nbsp;Software&nbsp;—&nbsp;a complex of programs of the system of information processing and software documents that are necessary for the usage of these programs and services for which Customer has paid, including any Updates relating thereto that may be provided hereunder or thereunder, and any derivative works of the foregoing</p>
<p>1.2.&nbsp;Update&nbsp;—&nbsp;any patch, bug fix, release, version, modification or successor to the Software</p>
<p>1.3.&nbsp;User&nbsp;—&nbsp;you or a named individual to whom you have granted access to use the Global Supplies on Customer’s behalf, regardless of whether or not the User actually accesses the Software. Users may be Customer's employees, consultants, contractors or agents.</p>
<p>1.4.&nbsp;Global Supplies&nbsp;—&nbsp;the specific internet-accessible service via the Website that provides usage of the Software that available to Customer over a network on a term-use basis and any related services.</p>
<p>1.5.&nbsp;Website&nbsp;—&nbsp;&nbsp;https://globsupplies.com, including subdomains and related Websites, as well as any information, texts, graphical, video and other materials, placed on the mentioned above Internet site or associated with the brand and Global Supplies trademark.</p>
<p>1.6.&nbsp;Price page&nbsp;—&nbsp;the web-page on the Website accessible via the link -globsupplies.com/pricing, that contains information about the Plans and terms of Subscription and services of Global Supplies<br> <br> 1.7 Offered services page&nbsp;—&nbsp;the web-page on the Website accessible via the link -&nbsp;globsupplies.com/pricing that contains information about the services and terms that provide Global Supplies</p>
<p>1.8.&nbsp;Services&nbsp;—&nbsp;terms of the Agreement which are accessible on the Price page, which determine the number of features and ways of providing by the Global Supplies and the cost of Subscription.</p>
<p>1.9.&nbsp;Services&nbsp;—&nbsp;shall mean that paid period or one-time use functional of Global Supplies which can be used, Customer has online access and right to use of the Serpstat on the conditions of chosen Services.</p>
<p>1.10.1 Additional related services: Global Supplies must provide reasonable efforts to provide the Services: <br> a) in accordance with the Agreement and Cyprus legislation; <br> b) provide reasonable care, skill and diligence; <br> c) use suitably skilled, experienced and qualified personnel.</p>
<p>1.10.&nbsp;Support&nbsp;— &nbsp;the ongoing services by Company to support Global Supplies.</p>
<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2. PERMITTED USE</strong></p>
<p>2.1. We grant you a limited, revocable, non-exclusive license to access and make personal use of the Global Supplies and the Software in accordance with your Plan. The Global Supplies and the Software, in whole or in part, may not be reproduced, republished, downloaded, uploaded, duplicated, copied, sold, resold, visited, or otherwise exploited for any commercial purpose without our prior written express consent.&nbsp;User login credentials may not be shared with anyone.</p>
<p>2.2.&nbsp;You will not:</p>
<p>2.2.1.1. Use the Global Supplies for any purposes other than the purpose expressly allowed by us herein;</p>
<p>2.2.1.2. Rent, lease, loan, sell, resell, sublicense, distribute or otherwise transfer the licenses granted herein or any materials contained in the Global Supplies;</p>
<p>2.2.1.3.&nbsp;Use the Global Supplies for any illegal purpose, harmful manner, or in violation of any local, state, national, or international law, including, without limitation, laws governing intellectual property and other proprietary rights, and data protection and privacy;</p>
<p>2.2.1.4. Remove, circumvent, disable, damage or otherwise interfere with security-related features of the Global Supplies, features that prevent or restrict use or copying of any content accessible through the Global Supplies, or features that enforce limitations on the use of the Global Supplies;</p>
<p>2.2.1.5. Reverse engineer, decompile, disassemble or otherwise attempt to discover the source code of the Software, Website or any part thereof;</p>
<p>2.2.1.6. Modify, adapt, translate or create derivative works based upon the Global Supplies; the content of the Services or any part thereof, except and only to the extent foregoing restriction is expressly prohibited by applicable law;&nbsp;</p>
<p>2.2.2. Intentionally interfere with or damage operation of the Global Supplies or any user’s enjoyment of them, by any means, including uploading or otherwise disseminating viruses, adware, spyware, worms, or other malicious code;</p>
<p>2.2.3. Use the Global Supplies in order to provide similar services to any third party or for competing with our Service;</p>
<p>2.2.4. Use Global Supplies or content on any platform or website not provided and approved by us, make any misrepresentations or abuse Global Supplies, or otherwise violate anyone’s rights or any applicable laws. Failure to abide by any of these rules may bring us to cancel your account and stop providing you with Global Supplies.</p>
<p>2.3. Without limitation, We may refuse, suspend or terminate a Subscription (or any renewal thereof) if User violates, threatens to violate, or reasonably appears to carry a significant danger of violating, this Agreement (or any other our policy or agreement) in any manner, and We reserve any and all other rights available at law or in equity with respect thereto</p>
<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 3. REGISTRATION AND FEES</strong></p>
<p>3.1. Company requires registration and verification as will be indicated on the Price page.</p>
<p>3.1.1. Each User wishes to join Global Supplies will have to register (create a User Account) through the Website at no cost. After registration, you become a Registrant and will have the ability to participate in some, but not all, of the features and services available within the Global Supplies. We reserve the right to deny or refuse any registration form or to cancel any existing accounts.</p>
<p>3.1.2.You hereby confirm that (a) your details provided therein are true and accurate details in the registration form. (b) you will maintain the accuracy of such information; (c) you are at least eighteen (18) years of age and have the capacity and authority to enter into this Agreement; and (d) your use of the Global Supplies does not violate any applicable law or regulation.</p>
<p>3.2. Only after creating an Account and making the first fee payment in amount that depends on the Service you choose, you become a Subscriber and will be able to use the Global Supplies in accordance with your chosen Service.</p>
<p>3.3. Any and all payments made in connection with the Global Supplies shall be non-refundable for any reason whether you used the Global Supplies in whole or in part of have not used it at all.</p>
<p>3.6. If your payment for verification for the next period is not received, your verified status will be canceled.</p>
<p>3.7. You are responsible for ensuring that the credit card associated with your account or subscription is up to date, that information posted in connection with it is accurate, and that you are authorized to use that credit card.&nbsp;</p>
<p>3.8. While Global Supplies may be paid for via invoice, We reserve the right to quote additional fees for invoiced accounts.</p>
<p>3.8.1. If We have entered into an invoicing relationship with you, the following terms apply unless superseded by written agreement:</p>
<p>3.8.1.1.&nbsp;You agree to pay all undisputed invoices within seven (7) days;</p>
<p>3.8.1.2.&nbsp;Payment shall be made in the currency of the country of your residence or registration of the legal entity/ or in EURO, in the amount equal to the cost of the chosen Plan in US dollars;</p>
<p>3.8.1.3.&nbsp;If you fail to pay an invoice, We reserve the right to cancel your Subscription, access to Global Supplies, and any data associated with your chosen service or verified status.</p>
<p>3.9.&nbsp;Depending on the country, a rate of foreign exchange and chosen kind of payment you can be additionally charged commission fees when paying for the Services. The tax rate depends on the payment information, which you shall give while paying for the Services.</p>
<ol start="4">
<li><strong>RIGHTS AND OBLIGATIONS OF THE RIGHTS</strong></li>
</ol>
<p><span style="font-weight: 400;">4.1. Company is obligated to provide Users with Support during eight (8) hours Monday through Friday. You can submit an unlimited number of requests for technical support per day. Request processing standard time from the date of its submission by the User of Global Supplies shall be twenty four (24) hours on work days.</span></p>
<p><span style="font-weight: 400;">4.2. Company has a right unilaterally to change a cost of Plans.</span></p>
<p><span style="font-weight: 400;">4.3. Company has right to refuse in Support if the request from User contains obscene language and rude speech.</span></p>
<ol start="5">
<li><strong>TERMINATION OF THE AGREEMENT AND CANCELLATION OF USER ACCOUNT.</strong></li>
</ol>
<p><span style="font-weight: 400;">5.1. You can cancel your User Account at any time. To cancel your User Account, send a request to the Support team via e-mail support@globsupplies.com.</span></p>
<p><span style="font-weight: 400;">5.2.We can unilateral cancel your User Account in case of:</span></p>
<p><span style="font-weight: 400;">5.2.1. Breaking the conditions of this Agreement.</span></p>
<p><span style="font-weight: 400;">5.2.2. Diversions from the normal usage patterns established by Company.</span></p>
<p><span style="font-weight: 400;">5.2.3. Attempts to inflict damages on the reputation or normal work of Global Supplies and the Website.</span></p>
<p><span style="font-weight: 400;">5.2.4. Creation of legal risks for the Company.</span></p>
<p><span style="font-weight: 400;">5.3. This Agreement terminates after the cancellation of User Account and/or Subscription.</span></p>
<ol start="6">
<li><strong>THIRD PARTY SERVICES</strong></li>
</ol>
<p><span style="font-weight: 400;">6.1. Global Supplies may provide, or users may provide, links to World Wide Web sites or resources (“Third Party Material”). Because we have no control over such Third Party Material, you acknowledge and agree that we are not responsible for the availability of such Third Party Material, and do not endorse and are not responsible or liable for any Third Party Material, advertising, products, or other materials on or available from such Third Party Material. You further acknowledge and agree that we shall not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with the use of or reliance on any such Third Party Material, goods or services available on or through any such Third Party Material. ACCESS AND USE OF THIRD PARTY MATERIALS, INCLUDING THE INFORMATION, MATERIALS AND SERVICES ON OR AVAILABLE THROUGH THIRD PARTY MATERIALS IS SOLELY AT YOUR OWN RISK.</span></p>
<ol start="7">
<li><strong>ELECTRONIC COMMUNICATIONS</strong></li>
</ol>
<p><span style="font-weight: 400;">7.1. When you use Global Supplies or send e-mails to us, you are communicating with us electronically. We, therefore, take this as your consent to receive communications from us electronically. By doing so you agree that all agreements, notices, disclosures and other communications that we provide to you electronically satisfy any and all legal requirement that such communications be in writing.</span></p>
<ol start="8">
<li><strong>DISCLAINER OF WARRANTIES AND LIMITATION LIABILITY</strong></li>
</ol>
<p><span style="font-weight: 400;">WE MAKE NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE OPERATION OF THIS SITE AND/OR SERVICES OR THE INFORMATION, CONTENT, MATERIALS, OR APPLICATIONS INCLUDED ON THE SERVICES, AND YOU EXPRESSLY AGREE THAT YOUR USE OF THESE SERVICES IS AT YOUR SOLE RISK. WE DO NOT GUARANTEE THAT GLOBAL SUPPLIES AND SOFTWARE WILL BE ERROR-FREE, UNINTERRUPTED, OR THAT IT WILL PROVIDE SPECIFIC RESULTS FROM USE OF SERPSTAT AND SOFTWARE OR ANY CONTENT, SEARCH OR LINK ON IT. GLOBAL SUPPLIES AND SOFTWARE AND THE CONTENT THEREIN ARE DELIVERED ON AN “AS-IS” AND “AS-AVAILABLE” BASIS. WE WILL NOT BE LIABLE FOR ANY DAMAGES OF ANY KIND ARISING FROM THE USE OF GLOBAL SUPPLIES AND SOFTWARE, INCLUDING WITHOUT LIMITATION, DIRECT, INDIRECT, INCIDENTAL, PUNITIVE AND CONSEQUENTIAL, SPECIAL OR PUNITIVE DAMAGES OR FOR LOST PROFITS, REVENUES OR BUSINESS OPPORTUNITIES, EVEN IF WE HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. TO THE FULL EXTENT PERMISSIBLE BY APPLICABLE LAW, WE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NONINFRINGEMENT, SYSTEM INTEGRATION, DATA ACCURACY, QUIET ENJOYMENT AND FREEDOM FROM VIRUSES OR OTHER HARMFUL CODE. WE WILL NOT BE LIABLE FOR ANY DELAY, DIFFICULTY IN USE, INACCURACY OF INFORMATION, DEVICE VIRUSES, MALICIOUS CODE OR OTHER DEFECT IN OUR GLOBAL SUPPLIES AND SOFTWARE. NO LICENSE TO THE USER IS IMPLIED IN THESE DISCLAIMERS. CERTAIN PROVINCIAL AND/OR STATE LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS, EXCLUSIONS, OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MIGHT HAVE ADDITIONAL RIGHTS. If these laws apply to you, some or all of the above-mentioned warnings, exceptions, or restrictions may not apply to you, and you may have additional rights.</span></p>
<ol start="9">
<li><strong>INTRODUCTION OF AMENDMENTS</strong></li>
</ol>
<p><span style="font-weight: 400;">9.1. Global Supplies shall reserve the right unilaterally to change, supplement, or replace some or all Conditions of this Agreement, having come into force from the date of its placement on Website, including, but not limited to, commission fees related to the use of Global Supplies. The further use of Global Supplies after such changes have been made shall mean, that you accept them. Changes shall have no retroactive effect and come into force no earlier than the fourteenth day after publication.</span></p>
<p><span style="font-weight: 400;">9.2. Every provision of this Agreement shall be independent and have legal force. If one of the provisions of these conditions becomes invalid, this will not influence the legitimacy of the other provisions.</span></p>
<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;10. OTHER TERMS</strong></p>
<p><span style="font-weight: 400;">10.1. This Agreement shall be governed by the laws of Cyprus.</span></p>
<p><span style="font-weight: 400;">10.2. Any dispute arising out of or in connection with this contract, including any question regarding its existence, validity or termination, shall be will be review at the Regional Arbitration Court in Limasol. The language is English. This agreement shall represent the full scope of terms between “Implementar” and “Subscriber” related to the services described therein. Any addition or amendment to this agreement requires written approval by both parties.</span></p>
                                        <br>
                                            <div class="text-center">
                        </div>
                                    </div>
HEREDOC
    ::Content::Page.create!(active: true, title:{en: "Terms and conditions Global Supplies"}, text:{en:text},seo_name: "policy",meta_title:{en:"Terms and conditions Global Supplies"} )
    ::Content::Page.create!(active: true, title:{en: "How rating works?"}, text:{en:"Some text"},seo_name: "rating",meta_title:{en:"How rating works?"} )

  end
end
