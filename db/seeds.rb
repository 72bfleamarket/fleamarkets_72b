categories=[
  {level1:"レディース",level1_children:[
                                      {level2:"トップス",level2_children:["Tシャツ/カットソー","スウェット","カーディガン"]},
                                      {level2:"ジャケット/アウター",level2_children:["テーラードジャケット","モッズコート", "ポンチョ"]}
                                      ]
  },
  {level1:"メンズ",level1_children:[
                                      {level2:"トップス",level2_children:["Tシャツ/カットソー","スウェット","カーディガン"]},
                                      {level2:"ジャケット/アウター",level2_children:["テーラードジャケット","モッズコート", "ポンチョ"]}
                                      ]
  }
]
categories.each.with_index(1) do |category,i|
level1_var="@category#{i}"
level1_val= Category.create(name:"#{category[:level1]}")
eval("#{level1_var} = level1_val")
category[:level1_children].each.with_index(1) do |level1_child,j|
level2_var="#{level1_var}_#{j}"
level2_val= eval("#{level1_var}.children.create(name:level1_child[:level2])")
eval("#{level2_var} = level2_val")
level1_child[:level2_children].each do |level2_children_val|
eval("#{level2_var}.children.create(name:level2_children_val)")
end
end
end