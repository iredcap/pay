<?php

/**
 *  +----------------------------------------------------------------------
 *  | 草帽支付系统 [ WE CAN DO IT JUST THINK ]
 *  +----------------------------------------------------------------------
 *  | Copyright (c) 2018 http://www.iredcap.cn All rights reserved.
 *  +----------------------------------------------------------------------
 *  | Licensed ( https://www.apache.org/licenses/LICENSE-2.0 )
 *  +----------------------------------------------------------------------
 *  | Author: Brian Waring <BrianWaring98@gmail.com>
 *  +----------------------------------------------------------------------
 */

namespace app\common\logic;


use app\common\library\enum\CodeEnum;

class BalanceCash extends BaseLogic
{

    /**
     * 获取打款列表
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param array $where
     * @param string $field
     * @param string $order
     * @param int $paginate
     * @return mixed
     */
    public function getOrderCashList($where = [], $field = 'a.*,b.account as myaccount', $order = 'a.create_time desc', $paginate = 15)
    {
        $this->modelBalanceCash->alias('a');

        $join = [
            ['user_account b', ' b.uid = a.uid'],
        ];

        $this->modelBalanceCash->join = $join;
        return $this->modelBalanceCash->getList($where, $field, $order, $paginate);
    }

    /**
     * 获取打款列表总数
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     * @param array $where
     * @return mixed
     */
    public function getOrderCashCount($where = []){
        return $this->modelBalanceCash->getCount($where);
    }

    public function saveUserCashApply($data){
        //TODO 数据验证
        $validate = $this->validateBalance->check($data);

        if (!$validate) {
            return ['code' => CodeEnum::ERROR, 'msg' => $this->validateBalance->getError()];
        }
    }
}