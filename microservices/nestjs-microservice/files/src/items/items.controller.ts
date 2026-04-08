import { Controller, Get, Post, Body } from '@nestjs/common';
import { MessagePattern, Payload } from '@nestjs/microservices';
import { ItemsService, Item } from './items.service';
import { CreateItemDto } from './dto/create-item.dto';

@Controller('items')
export class ItemsController {
  constructor(private readonly itemsService: ItemsService) {}

  // HTTP endpoints
  @Get()
  findAll(): Item[] {
    return this.itemsService.findAll();
  }

  @Post()
  create(@Body() dto: CreateItemDto): Item {
    return this.itemsService.create(dto);
  }

  // TCP message patterns
  @MessagePattern({ cmd: 'get_items' })
  handleGetItems(): Item[] {
    return this.itemsService.findAll();
  }

  @MessagePattern({ cmd: 'create_item' })
  handleCreateItem(@Payload() dto: CreateItemDto): Item {
    return this.itemsService.create(dto);
  }
}
