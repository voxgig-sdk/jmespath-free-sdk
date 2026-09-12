import { JmespathFreeEntityBase } from '../JmespathFreeEntityBase';
import type { JmespathFreeSDK } from '../JmespathFreeSDK';
import type { Control } from '../types';
import type { JmesPath, JmesPathCreateData } from '../JmespathFreeTypes';
declare class JmesPathEntity extends JmespathFreeEntityBase<JmesPath> {
    constructor(client: JmespathFreeSDK, entopts: any);
    make(this: JmesPathEntity): JmesPathEntity;
    create(this: any, reqdata?: JmesPathCreateData, ctrl?: Control): Promise<JmesPathEntity>;
}
export { JmesPathEntity };
