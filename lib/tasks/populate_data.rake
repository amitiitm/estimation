namespace :admin do
    desc "Populate Template / Categories / SubCategories"
    task :populate_template => :environment do
        file = File.read('public/templates.json')
        data_hash = JSON.parse(file)
        data_hash['template'].each do |template|
            t = Template.find_or_create_by(name: template['name'])
            t.description = template['description']
            t.save!
            puts "Updated Template : #{t.name}"
            data_hash['categories'].each do |category|
                category.each do |cat|
                    if template['id'] == cat['template_id']
                        c = Category.find_or_create_by(name: cat['name'])
                        c.description = cat['description']
                        c.template_id = t.id
                        c.save!
                        puts "Updated Category : #{c.name}"

                        data_hash['subcategories'].each do |sub|
                            sub.each do |sub_c|
                                if sub_c['category_id'] == cat['id']
                                    sc = SubCategory.find_or_create_by(name: sub_c['name'])
                                    sc.description = sub_c['description']
                                    sc.category_id = c.id
                                    sc.hours = sub_c['hours']
                                    sc.low_hours = sub_c['low_hours']
                                    sc.medium_hours = sub_c['medium_hours']
                                    sc.offer = sub_c['offer']
                                    sc.status = sub_c['status']
                                    sc.class_name = sub_c['class_name']
                                    sc.save!
                                    puts "Updated SubCategory : #{sc.name}"
                                end
                            end
                        end

                    end
                end
            end
        end
    end
end