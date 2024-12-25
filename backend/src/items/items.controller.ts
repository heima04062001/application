import { Controller, Get, Post, Put, Delete, Body, Param, HttpCode } from '@nestjs/common';
import { ItemsService } from './items.service';
import { CreateItemDto } from './dto/create-items.dto';
import { UpdateItemDto } from './dto/update-items.dto';
import { Item } from './items.model';  

@Controller('items')
export class ItemsController {
  constructor(private readonly itemsService: ItemsService) {}

  // アイテムの全件取得 (GET /items)
  @Get()
  @HttpCode(200)  // 明示的にステータスコード 200 を指定
  async findAll(): Promise<Item[]> {
    return this.itemsService.findAll();  // ItemsServiceのfindAllを呼び出し
  }

  // アイテムの個別取得 (GET /items/:id)
  @Get(':id')
  @HttpCode(200)  // 明示的にステータスコード 200 を指定
  async findOne(@Param('id') id: string): Promise<Item | null> {
    return this.itemsService.findById(parseInt(id));  // ItemsServiceのfindByIdを呼び出し
  }

  // アイテムの作成 (POST /items)
  @Post()
  @HttpCode(200)  // 明示的にステータスコード 200 を指定
  async create(@Body() createItemDto: CreateItemDto): Promise<Item> {
    return this.itemsService.create(createItemDto);  // ItemsServiceのcreateを呼び出し
  }

  // アイテムの削除 (DELETE /items/:id)
  @Delete(':id')
  @HttpCode(200)  // 明示的にステータスコード 200 を指定
  async remove(@Param('id') id: string): Promise<string> {
    const isDeleted = await this.itemsService.delete(parseInt(id));  // ItemsServiceのdeleteを呼び出し
    if (!isDeleted) {
      throw new Error('Item not found');
    }
    return 'Item deleted successfully';
  }

  // アイテムの更新 (PUT /items/:id)
  @Put(':id')
  @HttpCode(200)  // 明示的にステータスコード 200 を指定
  async update(
    @Param('id') id: string,
    @Body() updateItemDto: UpdateItemDto,
  ): Promise<Item | null> {
    return this.itemsService.update(parseInt(id), updateItemDto);  // ItemsServiceのupdateを呼び出し
  }
}
