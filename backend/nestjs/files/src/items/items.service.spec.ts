import { NotFoundException } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { ItemsService } from './items.service';

describe('ItemsService', () => {
  let service: ItemsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ItemsService],
    }).compile();

    service = module.get<ItemsService>(ItemsService);
  });

  it('creates an item with an incrementing id', () => {
    const first = service.create({ name: 'first' });
    const second = service.create({ name: 'second', description: 'details' });

    expect(first.id).toBe(1);
    expect(first.description).toBe('');
    expect(second.id).toBe(2);
    expect(service.findAll()).toHaveLength(2);
  });

  it('updates only the fields provided', () => {
    const item = service.create({ name: 'before', description: 'kept' });
    const updated = service.update(item.id, { name: 'after' });

    expect(updated.name).toBe('after');
    expect(updated.description).toBe('kept');
  });

  it('removes an item', () => {
    const item = service.create({ name: 'gone' });
    service.remove(item.id);

    expect(service.findAll()).toHaveLength(0);
  });

  it('throws NotFoundException for an unknown id', () => {
    expect(() => service.findOne(999)).toThrow(NotFoundException);
    expect(() => service.remove(999)).toThrow(NotFoundException);
  });
});
