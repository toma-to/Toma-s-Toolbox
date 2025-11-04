##
# Cactus_Single スターリンソート

#↓↓シミュレーション用。シミュレーションや実農場で呼び出す場合はコメントアウト外してね
# set_world_size(8)
# start_time = get_time()

# 行方向へのplant
def plant_row(upper):
    # 西から東へ植えていくループ
    for _ in range(8):
        west = measure(West)
        south = measure(South)
        # measure結果の補正（西端、南端対応）
        if west == None:
            west = 0
        if south == None:
            south = 0
        
        # 西と南の大きい方が下限
        lower = max(west, south)

        till()
        plant(Entities.Cactus)
        # 範囲外のサボテンを粛正するループ
        while not lower <= measure() <= upper:
            harvest()
            plant(Entities.Cactus)

        # 次のマスでは上限を1つ上げる
        upper += 1
        move(East)

# メイン処理
def run():
    # 南から北へ、行単位で植えていくループ
    for i in range(8):
        # 1行ごとに、西端のサイズ上限を上げていく
        plant_row(i)
        move(North)
    
    # 最後に植えたサボテンが成長しきるまで待機
    sleep_start = get_time()
    while get_time() - sleep_start < 1:
        pass

    # 収穫！！
    harvest()

# メイン処理を起動
run()


#↓↓シミュレーション用。シミュレーションや実農場で実行時間を表示したい時はコメントアウト外してね
# time = get_time() - start_time
# while True:
#     sec = time % 60
#     print(str(time // 60) + ':' + str(sec // 10) + str(sec % 10))
#     do_a_flip()
