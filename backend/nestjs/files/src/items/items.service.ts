import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateItemDto } from './dto/create-item.dto';
import { UpdateItemDto } from './dto/update-item.dto';

interface Item {
  id: number;
  name: string;
  description: string;
  createdAt: Date;
}

@Injectable()
export class ItemsService {
  private items: Item[] = [];
  private nextId = 1;

  findAll(): Item[] {
    return this.items;
  }

  findOne(id: number): Item {
    const item = this.items.find((i) => i.id === id);
    if (!item) {
      throw new NotFoundException(`Item #${id} not found`);
    }
    return item;
  }

  create(dto: CreateItemDto): Item {
    const item: Item = {
      id: this.nextId++,
      name: dto.name,
      description: dto.description ?? '',
      createdAt: new Date(),
    };
    this.items.push(item);
    return item;
  }

  update(id: number, dto: UpdateItemDto): Item {
    const item = this.findOne(id);
    if (dto.name !== undefined) item.name = dto.name;
    if (dto.description !== undefined) item.description = dto.description;
    return item;
  }

  remove(id: number): void {
    const index = this.items.findIndex((i) => i.id === id);
    if (index === -1) {
      throw new NotFoundException(`Item #${id} not found`);
    }
    this.items.splice(index, 1);
  }
}
