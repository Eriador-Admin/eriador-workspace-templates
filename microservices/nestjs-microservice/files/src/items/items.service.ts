import { Injectable } from '@nestjs/common';
import { CreateItemDto } from './dto/create-item.dto';

export interface Item {
  id: number;
  name: string;
  description: string;
}

@Injectable()
export class ItemsService {
  private items: Item[] = [
    { id: 1, name: 'Item One', description: 'First item' },
    { id: 2, name: 'Item Two', description: 'Second item' },
  ];

  private nextId = 3;

  findAll(): Item[] {
    return this.items;
  }

  create(dto: CreateItemDto): Item {
    const item: Item = { id: this.nextId++, ...dto };
    this.items.push(item);
    return item;
  }
}
